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
    var newsfeed: [NewsItem] = []
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newsSegmentedControl: UISegmentedControl!
    
    // View controller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        loadNewsfeed()
    }
    
    // Class methods
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadNewsfeed() {
        VKService.instance.loadNewsfeed { (vkNewsfeedResponse) in
            for vkNewsItem in vkNewsfeedResponse.response.items {
                let newsItem = NewsItem(with: vkNewsItem, from: vkNewsfeedResponse)
                self.newsfeed.append(newsItem)
            }
            self.tableView.reloadData()
        }
        
    }
    
    // @IBActions
}

extension NewsVC: UITableViewDelegate {
    
}

extension NewsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsfeed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CELL_NEWS) as? NewsCell else { return UITableViewCell() }
        cell.setupCell(with: newsfeed[indexPath.row])
        return cell
    }
}
