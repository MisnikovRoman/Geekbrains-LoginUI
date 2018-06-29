//
//  NewsCell.swift
//  LoginUI
//
//  Created by Роман Мисников on 26.06.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var avatarLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var repostsLbl: UILabel!
    @IBOutlet weak var commentsLbl: UILabel!
    @IBOutlet weak var viewsLbl: UILabel!

    func setupCell(with item: NewsItem) {
        avatarLbl.text = "URL: " + item.avatarUrl
        authorLbl.text = "From: " + item.author
        let postTime = getTimeToNow(from: item.date)
        dateLbl.text = postTime
        textLbl.text = item.body
        likesLbl.text = "" + String(item.likesCount)
        repostsLbl.text = "" + String(item.repostsCount)
        commentsLbl.text = "" + String(item.commentsCount)
        viewsLbl.text = "" + String(item.viewsCount)
    }
}
