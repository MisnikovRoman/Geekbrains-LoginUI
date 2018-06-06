//
//  SecondTableVC.swift
//  LoginUI
//
//  Created by Роман Мисников on 14.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class GroupsTableVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadVkGroupsData()
    }
    

    func loadVkGroupsData() {
        VKService.instance.loadUserGroups { (success) in
            
            if success {
                // table view reload data
                self.tableView.reloadData()
            } else {
                // show error
                simpleAlert(title: "Внимание", message: "Группы пользователя не были загружены", vc: self)
            }
            
        }
    }
    
    // TODO: - ⚠️ add segue to start screen
    @IBAction func unwindFromSearchGroups (_ segue: UIStoryboardSegue) {
        
        // check name of segue
        guard segue.identifier == UNWIND_TO_GROUPES else { return }
        // get controller to use his parameters (eg. tableView)
        let searchGroupsController = segue.source as! SearchGroupsTableVC
        // get indexPath
//        guard let indexPath = searchGroupsController.tableView.indexPathForSelectedRow else { return }
//        // get name of group to add
//        let groupName = SearchGroupData.getGroupes()[indexPath.row]
//
//        // adding
//        GroupsData.add(named: groupName, imageName: "test")
        // reload table view
        tableView.reloadData()
    }
    
}

// setup table view
extension GroupsTableVC {

    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let groups = VKRepository().loadData(type: Group.self) else { return 0 }
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_GROUP, for: indexPath) as! GroupCell
        // get data for each group from Realm DB
        guard let groups = VKRepository().loadData(type: Group.self) else { return UITableViewCell() }
        // setup cell
        cell.setupGroupCell(with: groups[indexPath.row])
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            
//            let deleteItemIndex = indexPath.row
//            
//            // delete from server
//            GroupsData.deleteGroup(byIndex: deleteItemIndex)
//            
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            
//        }
//    }
    
}


