//
//  UINavigationItem-backTintColor.swift
//  LoginUI
//
//  Created by Роман Мисников on 14.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

extension UINavigationController {
    @IBInspectable var backBtnColor: UIColor {
        get {
            if let color = self.navigationBar.tintColor {
                return color
            } else { return UIColor.clear }
        } set {
            self.navigationBar.tintColor = newValue
        }
    }
}
