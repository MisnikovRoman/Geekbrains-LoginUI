//
//  UserService.swift
//  LoginUI
//
//  Created by Роман Мисников on 28.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class VKService {
    
    private let queue = DispatchQueue.global(qos: .userInitiated)
    
    static let instance = VKService()
    
    // MARK: - VK requests
    
    // проверка auth token
    func checkAuthToken(completion: @escaping loadDataComplitionHandler) {
        // if token doesn't exist
        guard let token = UserData.instance.authToken else { completion(false); return }
        // get status data form vk to test auth
        
        // create url
        var urlWithParams = URLComponents(string: URL_VK_API_BASE + VK_GET_NEWSFEED)
        urlWithParams?.queryItems = [
            URLQueryItem(name: "user_id", value: "1"),
            URLQueryItem(name: "count", value: "50"),
            URLQueryItem(name: "v", value: "5.78"),
            URLQueryItem(name: "access_token", value: token)
        ]
        guard let url = urlWithParams?.url else { completion(false); return }
        
        Alamofire.request(url).responseJSON(queue: .global()) { (response) in
            // check errors
            guard response.error == nil else { completion(false); return }
            // check status code (200)
            guard response.response?.statusCode == 200 else { completion(false); return }
            // get json
            guard let json = response.value as? [String: Any] else { completion(false); return }
            // get status
            guard let _ = json["response"] as? [String: Any] else { completion(false); return }
            // in this step all is OK
            completion(true)
        }
    }
    
    // загрузить список друзей с параметрами
    func loadFriends(completion: @escaping loadDataComplitionHandler) {
        
        // get token from user data
        guard let token = UserData.instance.authToken else { return }
        
        // create URL
        var urlWithParams = URLComponents(string: URL_VK_API_BASE + VK_GET_FRIENDS)
        urlWithParams?.queryItems = [
            URLQueryItem(name: "order", value: "hints"),
            URLQueryItem(name: "count", value: "100"),
            URLQueryItem(name: "fields", value: "sex,bdate,photo_200,online"),
            URLQueryItem(name: "v", value: "5.78"),
            URLQueryItem(name: "access_token", value: token)
        ]
        guard let url = urlWithParams?.url else { return }
        
        // make request
        Alamofire.request(url).responseData { (response) in

            // check errors
            guard response.error == nil else {return}
            // check status code (200)
            guard response.response?.statusCode == 200 else { return }
            // get data
            guard let data = response.value else {return}
            
            // use swifty json framework
            guard let json = try? JSON(data: data) else {return}
            // get array of items (friends with parameters: id, first_name, last_name, deactivated, online)
            let items = json["response"]["items"].arrayValue
            // remap array: [Data] -> [Friend]
            let friendsArray = items.map() { Friend(jsonItems: $0) }
            // save data to FriendsData
            FriendsData.instance.friends = friendsArray
            // create VKRepository instance
            let repository = VKRepository()
            // save to Realm data base
            repository.savaData(data: friendsArray, groupPredicate: nil)
            
            completion(true)
        }
    }
    
    // получение фотографий человека
    func loadUserPhotos(id: String, size: VkImagesSize, completion: @escaping loadDataComplitionHandler) {
        // get token from user data
        guard let token = UserData.instance.authToken else { return }
        
        // create URL
        var urlWithParams = URLComponents(string: URL_VK_API_BASE + VK_GET_PHOTOS)
        urlWithParams?.queryItems = [
            URLQueryItem(name: "owner_id", value: id),
            URLQueryItem(name: "album_id", value: "profile"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.78"),
            URLQueryItem(name: "access_token", value: token)
        ]
        guard let url = urlWithParams?.url else { return }
        
        // make request
        Alamofire.request(url).responseData { (response) in
            
            // check errors
            guard response.error == nil else {return}
            // check status code (200)
            guard response.response?.statusCode == 200 else { return }
            // get data
            guard let data = response.value else {return}
            // parse JSON
            do {
                let json = try JSON(data: data)
                // get array of photos
                let items = json["response"]["items"].arrayValue
                // remap each element with Photo initializer
                let photos = items.map{ VKPhoto(jsonItem: $0) }
                // save photos
                PhotosData.instance.photos = photos
                // create VKRepository instance
                let repository = VKRepository()
                // save to Realm data base
                repository.savaData(data: photos, groupPredicate: nil)
            } catch let error {
                print(error.localizedDescription)
            }
            // completion handler
            completion(true)
        }
    }
    
    // получение групп текущего пользователя
    func loadUserGroups(completion: @escaping loadDataComplitionHandler) {
        // get token from user data
        guard let token = UserData.instance.authToken else { return }
        
        // create URL
        var urlWithParams = URLComponents(string: URL_VK_API_BASE + VK_GET_GROUPS)
        urlWithParams?.queryItems = [
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "description,members_count,status"),
            URLQueryItem(name: "v", value: "5.78"),
            URLQueryItem(name: "access_token", value: token)
        ]
        guard let url = urlWithParams?.url else { return }
        
        // make request
        Alamofire.request(url).responseData{ (response) in
            // check errors
            guard response.error == nil else {return}
            // check status code (200)
            guard response.response?.statusCode == 200 else { return }
            // get data
            guard let data = response.value else {return}
            // parse JSON
            do{
                // use standart decoding method
                let jsonParsedResponse = try JSONDecoder().decode(GroupResponse.self, from: data)
                // add group type
                jsonParsedResponse.response.items.forEach { $0.type = USER_GROUP }
                // create VKRepository instance
                let repository = VKRepository()
                // save to Realm data base
                repository.savaData(data: jsonParsedResponse.response.items, groupPredicate: .userGroup)
            }
            catch let err { print("->", err, "\nDescription:", err.localizedDescription) }
            
            // call completion handler
            completion(true)
        }
    }
    
    // получение групп по поисковому запросу
    func loadGroupsBySearch(searchText: String, completion: @escaping loadDataComplitionHandler) {
        
        // get token from user data
        guard let token = UserData.instance.authToken else { return }
        
        // create URL
        var urlWithParams = URLComponents(string: URL_VK_API_BASE + VK_SEARCH_GROUPS)
        urlWithParams?.queryItems = [
            URLQueryItem(name: "q", value: searchText),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "description,members_count,status"),
            URLQueryItem(name: "v", value: "5.78"),
            URLQueryItem(name: "access_token", value: token)
        ]
        guard let url = urlWithParams?.url else { return }
        
        // make requests
        Alamofire.request(url).responseData{ (response) in
            // check errors
            guard response.error == nil else {return}
            // check status code (200)
            guard response.response?.statusCode == 200 else { return }
            // get data
            guard let data = response.value else {return}
            // parse JSON
            do{
                let jsonParsedResponse = try JSONDecoder().decode(GroupResponse.self, from: data)
                // add group type (will be saved in database)
                jsonParsedResponse.response.items.forEach { $0.type = SEARCH_GROUP }
                // save to Realm
                VKRepository().savaData(data: jsonParsedResponse.response.items, groupPredicate: .searchGroup)
            }
            catch let err { print("->", err, "\nDescription:", err.localizedDescription) }
            
            // call completion handler
            completion(true)
        }
    }
    
    // получение новостной ленты
    func loadNewsfeed(completion: @escaping NewsComplitionHandler) {
        // get token from user data
        guard let token = UserData.instance.authToken else { return }
        
        // create URL
        var urlWithParams = URLComponents(string: URL_VK_API_BASE + VK_GET_NEWSFEED)
        urlWithParams?.queryItems = [
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "count", value: "50"),
            URLQueryItem(name: "v", value: "5.78"),
            URLQueryItem(name: "access_token", value: token)
        ]
        guard let url = urlWithParams?.url else { return }
        
        // make requests
        Alamofire.request(url).responseData { (dataResponse) in
            
            self.queue.async {
                print("🎈🎈🎈", Thread.current)
                // check errors
                guard dataResponse.error == nil else {return}
                // check status code (200)
                guard dataResponse.response?.statusCode == 200 else { return }
                // get data
                guard let data = dataResponse.value else {return}
                // parse JSON
                do {
                    
                    let VKDecoder = JSONDecoder()
                    VKDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    VKDecoder.dateDecodingStrategy = .secondsSince1970
                    
                    let response = try VKDecoder.decode(VKNewsResponse.self, from: data)
                    print("✅ Parcing success")
                    DispatchQueue.main.async {
                        completion(response)
                    }
                    
                } catch let err {
                    print("⚠️ Parcing error:", err, "\nDescription:", err.localizedDescription)
                }
            }
            
        }
    }

}

































