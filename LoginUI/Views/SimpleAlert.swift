//
//  SimpleAlert.swift
//  LoginUI
//
//  Created by Роман Мисников on 30.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

func simpleAlert(title: String, message: String, vc: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "Продолжить", style: .cancel, handler: nil)
    alert.addAction(action)
    vc.present(alert, animated: true, completion: nil)
}
