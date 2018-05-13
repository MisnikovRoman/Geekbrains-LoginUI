//
//  FirstTableViewController.swift
//  LoginUI
//
//  Created by Роман Мисников on 11.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class FirstTableVC: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    @IBAction func backToLoginVC(_ sender: Any) {
        UserData.instance.isLoggedIn = false
    }
    
    @IBAction func setLoggedIn(_ sender: Any) {
        UserData.instance.isLoggedIn = true
        print("Logged: \(UserData.instance.isLoggedIn)")
    }
    
    @IBAction func setLoggedOut(_ sender: Any) {
        UserData.instance.isLoggedIn = false
        print("Logged: \(UserData.instance.isLoggedIn)")
    }
    
}
