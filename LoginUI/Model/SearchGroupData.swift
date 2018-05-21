//
//  SearchGroupData.swift
//  LoginUI
//
//  Created by Роман Мисников on 21.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation

class SearchGroupData {
    
    // groups with can be addited manually
    private static var groups: [String] = ["1", "2", "3"]
    
    // count of elements in "groups" array
    static var count: Int { return groups.count }
    
    // empty flag
    static var isEmpty: Bool { return count==0 ? true : false }
    
    // adding new element
    static func addGroup(name: String) { groups.append(name) }
    
    // get existing groups
    static func getGroupes() -> [String] { return groups }
    
}
