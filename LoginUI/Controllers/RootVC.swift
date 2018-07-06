//
//  RootVC.swift
//  LoginUI
//
//  Created by Роман Мисников on 06.07.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class RootVC: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        activityIndicator.startAnimating()
        
        // login status of user
        if !UserData.instance.isLoggedIn {
            // segue to login page
            performSegue(withIdentifier: LOGIN_SEGUE, sender: nil)
            activityIndicator.stopAnimating()
    
        } else {
            // if user is logged - sthen check token
            VKService.instance.checkAuthToken { [weak self] (authIsValid) in
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    if authIsValid { self?.performSegue(withIdentifier: MAIN_SEGUE, sender: nil)}
                    else { self?.performSegue(withIdentifier: LOGIN_SEGUE, sender: nil) }
                }
            }
        }
    }
    
    // Enable return from WebVC
    @IBAction func unwindToMain (_ segue: UIStoryboardSegue) { }
}
