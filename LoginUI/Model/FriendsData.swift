//
//  FriendsData.swift
//  LoginUI
//
//  Created by Роман Мисников on 21.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation
import SwiftyJSON

class FriendsData {
    static let instance = FriendsData()
    var friends: [Friend] = []
}

class Friend {
    
    var firstName: String = ""
    var lastName: String = ""
    var id: Int = 0
    var isOnline: Bool = false
    var imageName: String = ""
    var birthday: String = ""
    
    init(jsonItems: JSON) {
        self.firstName = jsonItems["first_name"].stringValue
        self.lastName = jsonItems["last_name"].stringValue
        self.id = jsonItems["id"].intValue
        self.isOnline = jsonItems["online"].boolValue
        self.imageName = jsonItems["photo_200"].stringValue
        self.birthday = jsonItems["bdate"].stringValue
    }
}

struct Image {
    let url: String
    let id: Int
}

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
