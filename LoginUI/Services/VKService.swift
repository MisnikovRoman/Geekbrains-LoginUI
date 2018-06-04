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
    
    static let instance = VKService()
    
    // MARK: - Realm save functions
    
    func saveToRealm<T: Object>(_ array: [T]) {
        
        do {
            // create realm object (get access to data base)
            let realm = try Realm()
            // begin a write transaction on the Realm
            realm.beginWrite()
            // add data to base
            realm.add(array)
            // commit all write operations in the current write transaction
            try realm.commitWrite()
        } catch {
            print("<!> Realm error: ", error.localizedDescription)
        }
    }
    
    // сохранение друзей в в базу данных
    func saveToRealm(friends: [Friend]) {
        do {
            // create realm object (get access to data base)
            let realm = try Realm()
            // begin a write transaction on the Realm
            realm.beginWrite()
            // add data to base
            realm.add(friends)
            // commit all write operations in the current write transaction
            try realm.commitWrite()
        } catch {
            print("<!> Realm error: ", error.localizedDescription)
        }
    }
    
    // сохранения фотографий пользователя в базу данных
    func saveToRealm(vkPhotos: [VKPhoto]) {
        do {
            // create realm object (get access to data base)
            let realm = try Realm()
            // begin a write transaction on the Realm
            realm.beginWrite()
            // add data to base
            realm.add(vkPhotos)
            // commit all write operations in the current write transaction
            try realm.commitWrite()
        } catch {
            print("<!> Realm error: ", error.localizedDescription)
        }
    }
    
    // сохранение групп в базу данных
    func saveToRealm(groups: [Group]) {
        do {
            // create realm object (get access to data base)
            let realm = try Realm()
            // begin a write transaction on the Realm
            realm.beginWrite()
            // add data to base
            realm.add(groups)
            // commit all write operations in the current write transaction
            try realm.commitWrite()
        } catch {
            print("<!> Realm error: ", error.localizedDescription)
        }
    }
    
    // MARK: - VK requests
    
    /**
     Загрузить список друзей с параметрами
     */
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

            guard response.error == nil else {return}
            guard let data = response.value else {return}
            
            // use swifty json framework
            guard let json = try? JSON(data: data) else {return}
            // get array of items (friends with parameters: id, first_name, last_name, deactivated, online)
            let items = json["response"]["items"].arrayValue
            // remap array: [Data] -> [Friend]
            let friendsArray = items.map() { Friend(jsonItems: $0) }
            // save data to FriendsData
            FriendsData.instance.friends = friendsArray
            // save data to Realm
            //self.saveToRealm(friends: friendsArray)
            self.saveToRealm(friendsArray)
            
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
                // save photos to data base
                self.saveToRealm(photos)
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
                let jsonParsedResponse = try JSONDecoder().decode(GroupResponse.self, from: data)
                // fill group data
                jsonParsedResponse.response.items.forEach {
                    // print($0.name, $0.description, $0.membersCount)
                    // save data to instance
                    GroupsData.instance.groups.append($0)
                }
                // save data to Realm
                self.saveToRealm(GroupsData.instance.groups)
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
                // fill group data
                jsonParsedResponse.response.items.forEach {
                    print($0.name, $0.description, $0.membersCount)
                    GroupsData.instance.searchGroups.append($0) }
            }
            catch let err { print("->", err, "\nDescription:", err.localizedDescription) }
            
            // call completion handler
            completion(true)
        }
    }
    
}
