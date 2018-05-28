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
        
        UserService.instance.loadUserGroups { (success) in
            let text:String
            if success {
                text = "Группы пользователя загружены"
            } else {
                text = "Ошибка загрузки групп"
            }
            let alert = UIAlertController(title: "Поздравляем", message: text, preferredStyle: .alert)
            let action = UIAlertAction(title: "Продолжить", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupsData.getGroupsData().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_GROUP, for: indexPath) as! GroupCell

        cell.nameLbl.text = GroupsData.getGroupsData()[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let deleteItemIndex = indexPath.row
            
            // delete from server
            GroupsData.deleteGroup(byIndex: deleteItemIndex)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    @IBAction func unwindFromSearchGroups (_ segue: UIStoryboardSegue) {
        
        // check name of segue
        guard segue.identifier == UNWIND_TO_GROUPES else { return }
        // get controller to use his parameters (eg. tableView)
        let searchGroupsController = segue.source as! SearchGroupsTableVC
        // get indexPath
        guard let indexPath = searchGroupsController.tableView.indexPathForSelectedRow else { return }
        // get name of group to add
        let groupName = SearchGroupData.getGroupes()[indexPath.row]
        // adding
        GroupsData.add(named: groupName, imageName: "test")
        // reload table view
        tableView.reloadData()
    }
    
}
