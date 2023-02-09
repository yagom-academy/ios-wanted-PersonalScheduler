//
//  DateFormatter+Extension.swift
//  PersonalScheduler
//
//  Created by Kyo on 2023/02/08.
//

import Foundation

extension DateFormatter {
    static func removeTime(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY.MM.dd"
        return formatter.string(from: date)
    }
}
