//
//  String-dateTransform.swift
//  LoginUI
//
//  Created by Роман Мисников on 10.06.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation

extension String {
    
    func transformStringDate() -> String? {
        
        // count of point in string
        let pointCnt = self.reduce(0) { $1 == "." ? $0+1 : $0 }
        // create input and output formatters
        let inputDateFormatter = DateFormatter()
        let outputDateFormatter = DateFormatter()
        // setup date formatters
        inputDateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        inputDateFormatter.locale = Locale(identifier: "ru_RU")
        outputDateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        outputDateFormatter.locale = Locale(identifier: "ru_RU")
        // edit formatter according to points count in inout string
        switch pointCnt {
        case 1:
            inputDateFormatter.dateFormat = "d.M"
            outputDateFormatter.dateFormat = "d MMMM"
        case 2:
            inputDateFormatter.dateFormat = "d.M.yy"
            outputDateFormatter.dateFormat = "d MMMM yyyy"
        default:
            print("⚠️ Error: wrong date format")
            return nil
        }
        // safely get date from input
        guard let date = inputDateFormatter.date(from: self) else { return nil }
        // get string with output formatter
        let outputString = outputDateFormatter.string(from: date)
        
        return outputString
    }
}
