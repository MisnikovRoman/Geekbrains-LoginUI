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
    private static let groupsList = [ "Настоящий Лентач",
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
    private static let imagesList = [ "lentach",
                                      "fortnite",
                                      "vc",
                                      "",
                                      "",
                                      "",
                                      "",
                                      "",
                                      "",
                                      "",
                                      ""]
    
    static func getGroupsData () -> [String] { return groupsList }
    
    static func getImagesData () -> [String] { return imagesList }
}
