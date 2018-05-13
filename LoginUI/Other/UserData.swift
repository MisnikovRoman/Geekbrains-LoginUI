//
//  UserData.swift
//  LoginUI
//
//  Created by Роман Мисников on 11.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation

class UserData {
    
    static let instance = UserData()
    
    // MARK: - Properties
    public private(set) var validLogin = "admin"
    public private(set) var validPassword = "admin"
    
    // database, where you store key-value pairs persistently across launches of your app
    private let defaults = UserDefaults.standard
    
    // MARK: - User Defaults Database variables
    var isLoggedIn: Bool {
        get {
            // when someone calls instance.isLoggedIn we return data from data base
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }

        set {
            print("User \"admin\" status is: \(newValue)")
            // when someone wants to change logged status we write data to data base
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
            defaults.synchronize()
        }
    }
}
