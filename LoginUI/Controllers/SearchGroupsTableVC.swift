//
//  ThirdTableVC.swift
//  LoginUI
//
//  Created by Роман Мисников on 14.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class SearchGroupsTableVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchGroupData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_SEARCH_GROUP, for: indexPath) as! SearchGroupCell
        cell.nameLbl.text = SearchGroupData.getGroupes()[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        // add new group to groups list
//        let nameOfItemToAdd = SearchGroupData.getGroupes()[indexPath.row]
//        GroupsData.add(named: nameOfItemToAdd, imageName: "test")
    }
}
