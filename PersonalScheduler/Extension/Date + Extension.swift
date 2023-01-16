//
//  Date + Extension.swift
//  PersonalScheduler
//
//  Created by unchain on 2023/01/12.
//

import Foundation

extension Date {
    func formattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "KRW")
        return dateFormatter.string(from: self)
    }
}
