//
//  FirstTableViewController.swift
//  LoginUI
//
//  Created by Роман Мисников on 11.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class FriendsTableVC: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return FriendsData.getFriendsData().count
    }
    
    @IBAction func backToLoginVC(_ sender: Any) {
        print("-> Try to move back")
        
//        switchRootViewController(rootViewController: LoginVC, animated: true) {
//            print("-> Successfully changed root VC to LoginVC")
//        }
        
        UserData.instance.isLoggedIn = false
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_FRIEND) as! FriendCell
        cell.nameLbl.text = FriendsData.getFriendsData()[indexPath.row]
        
        return cell
    }
    
    

    
}
