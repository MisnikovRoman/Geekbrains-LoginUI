//
//  FirstTableViewController.swift
//  LoginUI
//
//  Created by Роман Мисников on 11.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit
import Alamofire

class UserFriendsVC: UITableViewController {

    var selectedUserID: String!
    
    // basic methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataFromServer()
    }
    
    func loadDataFromServer() {
    
        // 1st - load friends (id, first and last name)
        VKService.instance.loadFriends { (success) in
            
            DispatchQueue.main.async {
                if success { self.tableView.reloadData() }
                else { simpleAlert(title: "Внимание", message: "Список друзей не был загружен", vc: self) }
            }
        }
    }
    
    // IBActions
    @IBAction func logoutBtnTapped(_ sender: UIBarButtonItem) {
        // create exit confirmation alert controller
        let alert = UIAlertController(title: "", message: "Вы уверены что хотите выйти из своей учетной записи?", preferredStyle: .actionSheet)
        let confirmAction = UIAlertAction(title: "Подтвердить", style: .default) { (action) in
            UserData.instance.isLoggedIn = false
            self.dismiss(animated: true, completion: nil)
        } 
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let photosVC = segue.destination as? FriendPhotosVC {
            // pass data to the next view controller
            photosVC.userID = selectedUserID
        }
    }
}


// configure table view
extension UserFriendsVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // load friend from realm db
        guard let friends = VKRepository().loadData(type: Friend.self, groupPredicate: nil) else { return 0 }
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_FRIEND) as! FriendCell
        // repository instance
        let repository = VKRepository()
        // load friend from realm db
        guard let friends = repository.loadData(type: Friend.self, groupPredicate: nil) else { return UITableViewCell() }
        // setup cell
        cell.setupCell(with: friends[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // get friends from data base
        guard let friends = VKRepository().loadData(type: Friend.self, groupPredicate: nil) else { return }
        // get selected user id
        let userID = friends[indexPath.row].id
        
        self.selectedUserID = "\(userID)"
        performSegue(withIdentifier: PHOTOS_SEGUE, sender: nil)

    }
    
}
