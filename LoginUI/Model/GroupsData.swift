//
//  GroupsData.swift
//  LoginUI
//
//  Created by Роман Мисников on 21.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation

struct GroupResponse: Decodable {
    let response: Response
}

struct Response: Decodable {
    let count: Int
    let items: [Group]
}

struct Group: Decodable {
    let id: Int
    let name: String
    let photo50: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo50 = "photo_50"
    }
}

class GroupsData {
    static let instance = GroupsData()
    var groups: [Group] = []
}











