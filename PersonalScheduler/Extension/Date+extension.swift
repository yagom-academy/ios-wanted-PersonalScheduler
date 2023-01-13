//
//  Date+extension.swift
//  PersonalScheduler
//
//  Created by bard on 2023/01/13.
//

import Foundation.NSDate

extension Date {
    var timeStamp: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.dateStyle = .long
        let stringDate =  dateFormatter.string(from: self)
     
        return stringDate
    }
}
