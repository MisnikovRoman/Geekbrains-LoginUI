//
//  FirstCollectionViewController.swift
//  LoginUI
//
//  Created by Роман Мисников on 11.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FriendsCollectionVC: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        VKService.instance.loadUserPhotos(id: "1", size: .photoMax) { (success) in
            let text:String
            if success {
                text = "Фотография Павла Дурова загружена"
            } else {
                text = "Ошибка загрузки фотографии"
            }
            let alert = UIAlertController(title: "Поздравляем", message: text, preferredStyle: .alert)
            let action = UIAlertAction(title: "Продолжить", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension FriendsCollectionVC {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return FriendsData.instance.friends.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_FRIEND_2, for: indexPath) as! FriendsSecondTypeCell
        
        // Configure the cell
        cell.avatarImageView.image = #imageLiteral(resourceName: "avatar-man")
        
        return cell
    }
}
