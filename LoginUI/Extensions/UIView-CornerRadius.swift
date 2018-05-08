//
//  UIView-CornerRadius.swift
//  LoginUI
//
//  Created by Роман Мисников on 08.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        } set {
            self.layer.cornerRadius = newValue
        }
    }
}
