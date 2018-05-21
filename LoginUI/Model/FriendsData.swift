//
//  FriendsData.swift
//  LoginUI
//
//  Created by Роман Мисников on 21.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation

class FriendsData {
    private static let friends = [ "Роман Мисников",
                           "Анастасия Щепёткина",
                           "Вадим Врублевский",
                           "Иван Карманов",
                           "Иван Чепелкин",
                           "Данил Буслаев",
                           "Коля Голодный",
                           "Алексей Муравьёв" ]
    
    static func getFriendsData () -> [String] { return friends }
}
