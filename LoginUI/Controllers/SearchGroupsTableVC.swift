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
        
        VKService.instance.loadGroupsBySearch(searchText: "iphone") { (success) in
            let text:String
            if success {
                text = "Группы пользователя найдены загружены"
            } else {
                text = "Ошибка загрузки групп"
            }
            let alert = UIAlertController(title: "Поздравляем", message: text, preferredStyle: .alert)
            let action = UIAlertAction(title: "Продолжить", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension SearchGroupsTableVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchGroupData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_SEARCH_GROUP, for: indexPath) as! SearchGroupCell
        cell.nameLbl.text = SearchGroupData.getGroupes()[indexPath.row]
        return cell
    }
}
