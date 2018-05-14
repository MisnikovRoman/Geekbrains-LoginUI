//
//  UIBarButtonItem-tintColor.swift
//  LoginUI
//
//  Created by Роман Мисников on 14.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    @IBInspectable var newColor: UIColor {
        get {
            if let color = self.tintColor {
                return color
            } else {
                return UIColor.clear
            }
            
        } set {
            self.tintColor = newValue
        }
    }
}
