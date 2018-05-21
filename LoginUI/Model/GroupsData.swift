//
//  GroupsData.swift
//  LoginUI
//
//  Created by Роман Мисников on 21.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation

class GroupsData {
    
    // group names
    private static var groupsList = [ "Настоящий Лентач",
                                      "Fortnite",
                                      "Стартапы и бизнес",
                                      "The Village Петербург",
                                      "Пикабу",
                                      "Илья Варламов",
                                      "ВелоПитер",
                                      "Kickstarter в России",
                                      "PlayStation Россия",
                                      "• Мясная лавка • бургер.бар" ]
    
    // images names
    private static var imagesList = [ "lentach",
                                      "fortnite",
                                      "vc",
                                      "",
                                      "",
                                      "",
                                      "",
                                      "",
                                      "",
                                      ""]
    
    // get data from server
    static func getGroupsData () -> [String] { return groupsList }
    
    // get images names from server
    static func getImagesData () -> [String] { return imagesList }
    
    // add new element
    static func add(named: String, imageName: String) {
        groupsList.append(named)
        imagesList.append(imageName)
    }
    
    // delete item by name
    static func deleteGroup(named: String) {
        if groupsList.contains(named) {
            if let deleteIndex = groupsList.index(of: named) {
                groupsList.remove(at: deleteIndex)
            } else {
                (print("-> Error: no such element to delete"))
            }
        }
    }
    
    // delete item by index
    static func deleteGroup(byIndex index: Int) {
        guard index < groupsList.count else { return }
        guard index >= 0 else { return }
        
        groupsList.remove(at: index)
    }
}
