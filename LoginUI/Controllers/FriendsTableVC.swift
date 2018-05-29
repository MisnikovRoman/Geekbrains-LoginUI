//
//  FirstTableViewController.swift
//  LoginUI
//
//  Created by Роман Мисников on 11.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit
import Alamofire

class FriendsTableVC: UITableViewController {

    // basic methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        VKService.instance.loadFriends { (success) in
        
            if success {
                self.tableView.reloadData()
            } else {
                let alert = UIAlertController(title: "Внимание", message: "Список друзей не был загружен", preferredStyle: .alert)
                let action = UIAlertAction(title: "Продолжить", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // IBActions
    @IBAction func backToLoginVC(_ sender: Any) {
        print("-> Try to move back")
        
        // switchRootViewController(rootViewController: LoginVC, animated: true) {
        //     print("-> Successfully changed root VC to LoginVC")
        // }
        
        UserData.instance.isLoggedIn = false
        
    }

}

// configure table view
extension FriendsTableVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return FriendsData.instance.friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_FRIEND) as! FriendCell
        cell.setupCell(with: FriendsData.instance.friends[indexPath.row])
        
        return cell
    }
    
}
