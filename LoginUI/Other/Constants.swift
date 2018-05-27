//
//  Constants.swift
//  LoginUI
//
//  Created by Роман Мисников on 11.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation

// segues constants
let TABBAR_SEGUE = "TabBarSegue"
let UNWIND_TO_LOGIN = "BackToLoginVC"
let UNWIND_TO_GROUPES = "BackToGroups"

// user date constants
let LOGGED_IN_KEY = "loggedIn"

// storyboard constants
let STORYBOARD_TABBARCONTROLLER = "TabBarController"
let STORYBOARD_LOGGEDIN = "LoginVC"

// cell constants
let CELL_FRIEND = "FriendCellIdentifier"
let CELL_FRIEND_2 = "Friend2CellIdentifier"
let CELL_GROUP = "GroupCellIdentifier"
let CELL_SEARCH_GROUP = "SearchGroupCell"

// url constants
let URL_VK_AUTH = "https://oauth.vk.com/authorize"      // url to authentification page
let URL_VK_REDIRECT = "https://oauth.vk.com/blank.html" // where to go after authentification

// other constants
let CLIENT_ID = "123-456-789"   // VK app identification number
let APP_SCOPE = "262150"        // Битовая маска настроек доступа приложения (https://vk.com/dev/permissions)
