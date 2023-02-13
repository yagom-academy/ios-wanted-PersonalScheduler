//
//  Date+.swift
//  PersonalScheduler
//
//  Created by junho lee on 2023/02/09.
//

import Foundation

extension Date {
    static let dateFormatter = DateFormatter()

    func isToday() -> Bool {
        let calendar = Calendar.current
        return calendar.startOfDay(for: self) == calendar.startOfDay(for: Date())
    }

    func isEarlierThanToday() -> Bool {
        let calendar = Calendar.current
        return calendar.startOfDay(for: self) < calendar.startOfDay(for: Date())
    }

    func localizedDateTimeString() -> String {
        let formatter = Self.dateFormatter
        formatter.locale = Locale(identifier: Locale.preferredLanguages.first ?? Locale.current.description)
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter.string(from: self)
    }
}
