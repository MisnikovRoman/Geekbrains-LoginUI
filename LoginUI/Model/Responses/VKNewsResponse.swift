//
//  News.swift
//  LoginUI
//
//  Created by Роман Мисников on 26.06.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation

struct VKNewsResponse: Decodable {
    
    struct VKNewsResponseData: Decodable {
        
        struct VKItem: Decodable {
            
            struct VKAttachment: Decodable {
                
                struct VKPhoto: Decodable {
                    
                    struct VKSize: Decodable {
                        
                        var type: String
                        var url: String
                    }
                    
                    var id: Int
                    var albumId: Int
                    var ownerId: Int
                    var userId: Int
                    var sizes: [VKSize]
                    var text: String
                    var date: Date
                    var accessKey: String
                }
                
                var type: String
                var photo: VKPhoto?
            }
            struct VKPostSource: Decodable { var type: String }
            struct VKComment: Decodable { var count: Int }
            struct VKLikes: Decodable { var count, userLikes: Int }
            struct VKReposts: Decodable { var count: Int }
            struct VKViews: Decodable { var count: Int }
            
            var type: String
            var sourceId: Int
            var date: Date
            var postId: Int
            var postType: String
            var text: String
            var markedAsAds: Int? //markedAsAds
            var attachments: [VKAttachment]?
            var postSource: VKPostSource
            var comments: VKComment
            var likes: VKLikes
            var reposts: VKReposts
            var views: VKViews
        }
        
        struct VKProfile: Decodable {
            
            // ⚠️ - заполнить
        }
        
        struct VKGroup: Decodable {
            
            var id: Int
            var name: String
            var screenName: String
            var isClosed: Int
            var type: String
            var isAdmin: Int
            var isMember: Int
            var photo50: String
            var photo100: String
            var photo200: String
        }
        
        var items: [VKItem]
        var profiles: [VKProfile]
        var groups: [VKGroup]
        var nextFrom: String
    }
    
    var response: VKNewsResponseData
}
