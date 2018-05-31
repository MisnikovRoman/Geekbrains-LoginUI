//
//  SearchGroupCell.swift
//  LoginUI
//
//  Created by Роман Мисников on 21.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class SearchGroupCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var numberOfPeopleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    func setupCell(group: Group) {
        nameLbl.text = group.name
        descriptionLbl.text = group.status
        
        let count = group.membersCount
        let textCount = count > 1000 ? "\(count/1000)К" : "\(count)"
        numberOfPeopleLbl.text = textCount
        
        let stringUrl = group.imageName
        if let url = URL(string: stringUrl) {
            avatarImageView.kf.setImage(with: url)
        }
        
    }
}
