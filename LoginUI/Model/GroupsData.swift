//
//  GroupsData.swift
//  LoginUI
//
//  Created by Роман Мисников on 21.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation
import RealmSwift

struct GroupResponse: Decodable  {
    let response: Response
}

struct Response: Decodable {
    let count: Int
    let items: [Group]
}

class Group: Object, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var imageName: String = ""
    @objc dynamic var groupDescription: String = ""
    @objc dynamic var membersCount: Int = 0
    @objc dynamic var status: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageName = "photo_100"
        case groupDescription = "description"
        case membersCount = "members_count"
        case status
    }
}

class GroupsData {
    static let instance = GroupsData()
    var groups: [Group] = []
    var searchGroups: [Group] = []
}











