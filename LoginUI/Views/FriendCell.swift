//
//  FriendCell.swift
//  LoginUI
//
//  Created by Роман Мисников on 21.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var birthdayLbl: UILabel!
    @IBOutlet weak var statusView: UIView!
    
    func setupCell(with friend: Friend) {
        nameLbl.text = friend.firstName + " " + friend.lastName
        statusView.backgroundColor = friend.isOnline ? .blue : .clear
    }
}
