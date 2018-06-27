//
//  NewsVC.swift
//  LoginUI
//
//  Created by Роман Мисников on 26.06.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class NewsVC: UIViewController {
    
    // Variables
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newsSegmentedControl: UISegmentedControl!
    
    // View controller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    // Class methods
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // @IBActions
}

extension NewsVC: UITableViewDelegate {
    
}

extension NewsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
