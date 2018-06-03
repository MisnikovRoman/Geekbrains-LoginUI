//
//  FriendsData.swift
//  LoginUI
//
//  Created by Роман Мисников on 21.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class FriendsData {
    static let instance = FriendsData()
    var friends: [Friend] = []
}

class Friend: Object {
    
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var isOnline: Bool = false
    @objc dynamic var imageName: String = ""
    @objc dynamic var birthday: String = ""
    
    convenience init(jsonItems: JSON) {
        self.init()
        
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

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
