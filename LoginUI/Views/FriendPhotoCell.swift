//
//  FriendsSecondTypeCell.swift
//  LoginUI
//
//  Created by Роман Мисников on 21.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class FriendPhotoCell: UICollectionViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    
    func setupCell(photo: VKPhoto) {
        let url = URL(string: photo.url)
        avatarImageView.kf.setImage(with: url)
    }
    
}
