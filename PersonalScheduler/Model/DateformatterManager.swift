//
//  DateformatterManager.swift
//  PersonalScheduler
//
//  Created by Mangdi on 2023/02/09.
//

import Foundation

final class DateformatterManager {
    static let shared: DateformatterManager = DateformatterManager()
    private init() { }

    let formatter = DateFormatter()

    func convertDateToString(date: Date) -> String {
        formatter.dateFormat = "yyyy.MM.dd"
        let date = formatter.string(from: date)
        return date
    }

    func convertStringToDate(dateText: String) -> Date? {
        formatter.dateFormat = "yyyy.MM.dd"
        guard let date = formatter.date(from: dateText) else { return nil }
        return date
    }
}
