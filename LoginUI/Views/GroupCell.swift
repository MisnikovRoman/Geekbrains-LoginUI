//
//  GroupCell.swift
//  LoginUI
//
//  Created by Роман Мисников on 21.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var membersCount: UILabel!
    
    func setupGroupCell(with group: Group) {
        nameLbl.text = group.name
        statusLbl.text = group.status
        membersCount.text = "\(group.membersCount) чел."
        
        let stringUrl = group.imageName
        if let url = URL(string: stringUrl) {
            avatarImageView.kf.setImage(with: url)
        }
        
    }
    
}
