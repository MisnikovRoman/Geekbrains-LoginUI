//
//  ViewController.swift
//  LoginUI
//
//  Created by Роман Мисников on 07.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    // MARK: - Variables
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Main methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // subscribe to keyboard will show notification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        // subscribe to keyboard will show notification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // remove all observers when view will disappear
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    // MARK: - @IBActiones
    // to enable return from any VC
    @IBAction func unwindToLoginVC (_ segue: UIStoryboardSegue) { }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        if (username == UserData.instance.validLogin && password == UserData.instance.validPassword) {
            
            UserData.instance.isLoggedIn = true
            
            // if entered pair is valid
            performSegue(withIdentifier: TABBAR_SEGUE, sender: nil)
        } else {
            // show alert with error
            let alert = UIAlertController(title: "Ошибка", message: "Пользователя с такой парой логин/пароль не существует", preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alert.addAction(actionOK)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - Notifications handlers
    @objc func keyboardWasShown(notification: Notification) {
        // get keyboard size
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsetsMake(0, 0, kbSize.height, 0)
        
        // add content insets to scroll view
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
     @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    
    }

}

