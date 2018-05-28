//
//  UserService.swift
//  LoginUI
//
//  Created by Роман Мисников on 28.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation
import Alamofire

class UserService {
    
    static let instance = UserService()
    
    func loadFriends(completionHandler: @escaping loadDataComplitionHandler) {
        
        // get token from user data
        guard let token = UserData.instance.authToken else { return }
        
        // create URL
        var urlWithParams = URLComponents(string: URL_VK_API_BASE + VK_GET_FRIENDS)
        urlWithParams?.queryItems = [
            URLQueryItem(name: "order", value: "hints"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "fields", value: "sex, bdate"),
            URLQueryItem(name: "v", value: "5.78"),
            URLQueryItem(name: "access_token", value: token)
        ]
        guard let url = urlWithParams?.url else { return }
        
        // make request
        Alamofire.request(url).responseJSON { (response) in

            guard response.error == nil else {return}
            guard let json = response.result.value else {return}

            print("JSON: \(json)") // serialized json response
            
            completionHandler(true)
        }
    }
}
