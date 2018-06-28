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
    
    return "Posted: \(backDays) days \(backHours) hours \(backMinutes) minutes \(backSeconds) seconds"
}
