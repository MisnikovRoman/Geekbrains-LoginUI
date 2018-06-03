//
//  PhotosData.swift
//  LoginUI
//
//  Created by Роман Мисников on 31.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class PhotosData {
    static let instance = PhotosData()
    var photos:[VKPhoto] = []
}

class VKPhoto: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var url: String = ""
    @objc dynamic var likesCount: Int = 0
    
    convenience init(jsonItem: JSON) {
        self.init()
        
        self.id = jsonItem["id"].intValue
        let photosWithSizes = jsonItem["sizes"].arrayValue
        let firstPhotoSize = photosWithSizes[0]
        self.url = firstPhotoSize["url"].stringValue
        self.likesCount = jsonItem["likes"]["count"].intValue
    }
}
