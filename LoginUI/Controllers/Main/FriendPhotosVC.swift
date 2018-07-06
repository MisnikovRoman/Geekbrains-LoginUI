//
//  FirstCollectionViewController.swift
//  LoginUI
//
//  Created by Роман Мисников on 11.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FriendPhotosVC: UICollectionViewController {
   
    var userID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        loadPhotos()
        
    }
    
    func loadPhotos() {
        guard let id = Int(userID) else { return }
        guard id > 0 else { return }
        
        VKService.instance.loadUserPhotos(id: userID, size: VkImagesSize.photo100) { (success) in
            DispatchQueue.main.async {
                if success {
                    self.collectionView?.reloadData()
                } else {
                    simpleAlert(title: "Внимание", message: "Ошибка загрузки данных пользователя", vc: self)
                }
            }
        }
    }
     
    deinit {
        print(#function)
        PhotosData.instance.photos = []
    }
}

extension FriendPhotosVC {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let photos = VKRepository().loadData(type: VKPhoto.self, groupPredicate: nil) else { return 0 }
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_FRIEND_2, for: indexPath) as! FriendPhotoCell
        // load data from Realm DB
        guard let photos = VKRepository().loadData(type: VKPhoto.self, groupPredicate: nil) else { return UICollectionViewCell() }
        // setup each cell
        cell.setupCell(photo: photos[indexPath.item])
        
        return cell
    }
}