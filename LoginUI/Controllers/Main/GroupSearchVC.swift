//
//  ThirdTableVC.swift
//  LoginUI
//
//  Created by Роман Мисников on 14.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class GroupSearchVC: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func searchBtnPressed(_ sender: Any) {
        
        // get data from search bar
        guard let text = searchBar.text else { return }
        guard text != "" else { return }
        
        // make search request
        VKService.instance.loadGroupsBySearch(searchText: text) { (success) in
            if success {
                self.tableView.reloadData()
            } else {
                simpleAlert(title: "Внимание", message: "Невозможно осуществить поиск по группам", vc: self)
            }
        }
    }
}

extension GroupSearchVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // create repository
        let repo = VKRepository()
        // load groups
        guard let searchGroups = repo.loadData(type: Group.self, groupPredicate: .searchGroup) else { return 0 }
        // return groups count
        return searchGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_SEARCH_GROUP, for: indexPath) as! SearchGroupCell
        // load from data base
        let repo = VKRepository()
        guard let searchGroups = repo.loadData(type: Group.self, groupPredicate: .searchGroup) else { return UITableViewCell() }
        // configure cell with loaded data
        cell.setupCell(group: searchGroups[indexPath.row])
        // return configured cell
        return cell
    }
}
