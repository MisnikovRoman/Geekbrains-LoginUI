//
//  OtherFunctions.swift
//  LoginUI
//
//  Created by Роман Мисников on 28.06.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation

func getTimeToNow(from date: Date) -> String {
    
    let backTime =  -Int(date.timeIntervalSinceNow)
    
    let backDays = backTime / 86400
    let backHours = backTime % 86400 / 3600
    let backMinutes = backTime % 86400 % 3600 / 60
    let backSeconds = backTime % 86400 % 3600 % 60
    
    var result = ""
    if backDays != 0 { return "много часов назад" }
    if backHours != 0 {
        result += "\(backHours) час"
        switch backHours {
        case 1: result += ""
        case 2...4 : result += "а"
        default: result += "ов"
        }
    }
    result += "\(backMinutes) минут"
    let backMinutesLastSign = backMinutes % 10
    let backMinutesTensCount = backMinutes / 10
    
    // 1, 21, 31, 41, 51
    if backMinutesLastSign == 1 && backMinutesTensCount != 1 { result += "у" }
    // 2 3 4 22 23 24 32 33 34 ...
    if (backMinutesLastSign >= 2 && backMinutesLastSign <= 4) || (backMinutesTensCount >= 2 && backMinutesTensCount <= 5) { result += "ы" }
    
    return result + " назад"
}
