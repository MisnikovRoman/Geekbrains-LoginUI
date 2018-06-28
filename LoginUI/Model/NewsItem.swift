//
//  NewsItem.swift
//  LoginUI
//
//  Created by Роман Мисников on 28.06.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation

class NewsItem {
    
    let likesCount, commentsCount, repostsCount, viewsCount: Int
    let avatarUrl, author, body: String
    let date: Date
    
    init(with item: VKNewsResponse.VKNewsResponseData.VKItem, from newsfeed: VKNewsResponse) {
        
        // avatar (main image)
        var avatarUrl: String {
            let authorId = item.sourceId
            if authorId > 0 {
                return "⚠️ Didn't loaded user photo"
            } else {
                let allGroups = newsfeed.response.groups
                guard let indexOfAuthor = (allGroups.index{ $0.id == -authorId }) else { return "Unknown group" }
                return allGroups[indexOfAuthor].photo100
            }
        }
        self.avatarUrl = avatarUrl
        
        // author (user name or group name)
        var authorName: String {
            let authorId = item.sourceId
            if authorId > 0 {
                return "Unknown user"
            } else {
                let allGroups = newsfeed.response.groups
                guard let indexOfAuthor = (allGroups.index{ $0.id == -authorId }) else { return "Unknown group" }
                return allGroups[indexOfAuthor].name
            }
            
        }
        
        self.author = authorName
        // date (in unixtime)
        self.date = item.date
        // body
        self.body = item.text
        // likes count
        self.likesCount = item.likes.count
        // comments count
        self.commentsCount = item.comments.count
        // reposts count
        self.repostsCount = item.reposts.count
        // views count
        self.viewsCount = item.views.count
    }
}


extension NewsItem: CustomStringConvertible {
    var description: String {
        var resStr = ""
        resStr += "Author: \(author)\n"
        resStr += "Text: \(body)\n"
        resStr += "Date: \(getTimeToNow(from: date))\n"
        resStr += "Avatar: \(avatarUrl)\n"
        resStr += "Likes: \(likesCount), "
        resStr += "Comments: \(commentsCount), "
        resStr += "Reposts: \(repostsCount), "
        resStr += "Views: \(viewsCount)\n"
        return resStr
    }
}
