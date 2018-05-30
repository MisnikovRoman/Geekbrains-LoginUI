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
        loadDataFromServer()
        
    }
    
    func loadDataFromServer() {
    
        // 1st - load friends (id, first and last name)
        VKService.instance.loadFriends { (success) in
            
            if success {
                // create list of IDs: "12314,892635,982365..."
                var ids = ""
                for (index, friend) in FriendsData.instance.friends.enumerated() {
                    ids += index != FriendsData.instance.friends.count-1 ? "\(friend.id)," : "\(friend.id)"
                }
                
                // load images JSON array for ids
                VKService.instance.loadUserPhotos(id: ids, size: VkImagesSize.photo50) { (success) in
                    if success {
                        self.tableView.reloadData()
                    } else {
                        simpleAlert(title: "Внимание", message: "Невозможно загрузить подробные данные о пользователях", vc: self)
                    }
                }
            } else {
                simpleAlert(title: "Внимание", message: "Список друзей не был загружен", vc: self)
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
