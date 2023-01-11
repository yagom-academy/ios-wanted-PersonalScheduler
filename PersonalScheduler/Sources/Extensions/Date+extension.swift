//
//  Date+extension.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/11.
//

import Foundation

extension Date {
    
    func toString(_ format: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
    
}

enum DateFormat: String {
    case hourMinute = "a h:mm"
    case yyyyMMddEEEE = "yyyy. MM. dd. EEEE"
    case month = "M"
    case day = "d"
    case week = "E"
}
