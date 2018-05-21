//
//  AppDelegate.swift
//  LoginUI
//
//  Created by Роман Мисников on 07.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        var initialViewController: UIViewController
        
        // switch between initial view controllers
        if UserData.instance.isLoggedIn {
            initialViewController = storyboard.instantiateViewController(withIdentifier: STORYBOARD_TABBARCONTROLLER)
        } else {
            initialViewController = storyboard.instantiateViewController(withIdentifier: STORYBOARD_LOGGEDIN)
        }
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
   
}

