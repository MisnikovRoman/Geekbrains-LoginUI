//
//  PhotosData.swift
//  LoginUI
//
//  Created by Роман Мисников on 31.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation
import SwiftyJSON

class PhotosData {
    static let instance = PhotosData()
    var photos:[VKPhoto] = []
}

struct VKPhoto {
    let id: Int
    let url: String
    let likesCount: Int
    
    init(jsonItem: JSON) {
        self.id = jsonItem["id"].intValue
        let photosWithSizes = jsonItem["sizes"].arrayValue
        let firstPhotoSize = photosWithSizes[0]
        self.url = firstPhotoSize["url"].stringValue
        self.likesCount = jsonItem["likes"]["count"].intValue
    }
}
