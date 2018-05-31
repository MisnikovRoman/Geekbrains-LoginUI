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

    var selectedUserID: String!
    
    // basic methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataFromServer()
        
    }
    
    func loadDataFromServer() {
    
        // 1st - load friends (id, first and last name)
        VKService.instance.loadFriends { (success) in
            
            if success { self.tableView.reloadData() }
            else { simpleAlert(title: "Внимание", message: "Список друзей не был загружен", vc: self) }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let photosVC = segue.destination as? FriendsCollectionVC {
            // pass data to the next view controller
            photosVC.userID = selectedUserID
        }
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // get selected user id
        let userID = FriendsData.instance.friends[indexPath.row].id
        
        self.selectedUserID = "\(userID)"
        performSegue(withIdentifier: PHOTOS_SEGUE, sender: nil)

    }
    
}
