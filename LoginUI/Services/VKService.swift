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

class VKService {
    
    static let instance = VKService()
    
    // загрузить список друзей с параметрами
    func loadFriends(completion: @escaping loadDataComplitionHandler) {
        
        // get token from user data
        guard let token = UserData.instance.authToken else { return }
        
        // create URL
        var urlWithParams = URLComponents(string: URL_VK_API_BASE + VK_GET_FRIENDS)
        urlWithParams?.queryItems = [
            URLQueryItem(name: "order", value: "hints"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "fields", value: "sex, bdate"),
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
            
            completion(true)
        }
    }
    
    // получение фотографий человека
    func loadUserPhotos(id: String, size: VkImagesSize, completion: @escaping loadDataComplitionHandler) {
        // get token from user data
        guard let token = UserData.instance.authToken else { return }
        
        // create URL
        var urlWithParams = URLComponents(string: URL_VK_API_BASE + VK_GET_USERS)
        urlWithParams?.queryItems = [
            URLQueryItem(name: "user_ids", value: id),
            URLQueryItem(name: "fields", value: size.rawValue),
            URLQueryItem(name: "v", value: "5.78"),
            URLQueryItem(name: "access_token", value: token)
        ]
        guard let url = urlWithParams?.url else { return }
        
        // make request
        Alamofire.request(url).responseJSON { (response) in
            
            guard response.error == nil else {return}
            guard let json = response.result.value else {return}
            
            print("JSON: \(json)") // serialized json response
            
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
            URLQueryItem(name: "v", value: "5.78"),
            URLQueryItem(name: "access_token", value: token)
        ]
        guard let url = urlWithParams?.url else { return }
        
        // make request
        Alamofire.request(url).responseJSON { (response) in
            
            guard response.error == nil else {return}
            guard let json = response.result.value else {return}
            
            print("JSON: \(json)") // serialized json response
            
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
            URLQueryItem(name: "type", value: "group"),
            URLQueryItem(name: "v", value: "5.78"),
            URLQueryItem(name: "access_token", value: token)
        ]
        guard let url = urlWithParams?.url else { return }
        
        // make request
        Alamofire.request(url).responseJSON { (response) in
            
            guard response.error == nil else {return}
            guard let json = response.result.value else {return}
            
            print("JSON: \(json)") // serialized json response
            
            completion(true)
        }
    }
    
}
