//
//  StrokeButton.swift
//  LoginUI
//
//  Created by Роман Мисников on 05.07.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

@IBDesignable
class StrokeButton: UIButton {
    
    // to edit properties in app
    override func awakeFromNib() {
        setupView()
    }
    
    // to edit properties in interface builder
    override func prepareForInterfaceBuilder() {
        // call only in interface builder for @IBDesignable
        super.prepareForInterfaceBuilder()
        setupView()
        
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.height / 3
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        self.clipsToBounds = true
    }

    
    
}
