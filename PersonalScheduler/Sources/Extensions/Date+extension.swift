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
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = format.rawValue
        let localeID = Locale.preferredLanguages.first
        let deviceLocale = Locale(identifier: localeID ?? "ko-kr").languageCode
        formatter.locale = Locale(identifier: deviceLocale ?? "ko-kr")
        return formatter.string(from: self)
    }
    
    func nearestHour() -> Date {
        var components = NSCalendar.current.dateComponents([.minute], from: self)
        let minute = components.minute ?? 0
        components.minute = minute >= 30 ? 60 - minute : -minute
        return Calendar.current.date(byAdding: components, to: self) ?? Date()
    }
    
    func plusHour(_ hour: Int) -> Date {
        guard hour > 0 else {
            return self
        }
        return Date(timeIntervalSinceNow: self.timeIntervalSinceNow + Double((3600 * hour)))
    }
    
    func isFuture(from date: Date) -> Bool {
        let result: ComparisonResult = self.compare(date)
        return result == .orderedAscending
    }
    
    func contains(start: Date, end: Date) -> Bool {
        let period = start.timeIntervalSinceReferenceDate...end.timeIntervalSinceReferenceDate
        return period.contains(self.timeIntervalSinceReferenceDate)
    }
    
    func isEqualDay(from date: Date) -> Bool {
        let lhs = Calendar.current.component(.day, from: self)
        let rhs = Calendar.current.component(.day, from: date)
        return lhs == rhs
    }
    
    func isEqualMonth(from date: Date) -> Bool {
        let lhs = Calendar.current.component(.month, from: self)
        let rhs = Calendar.current.component(.month, from: date)
        return lhs == rhs
    }
    
}

enum DateFormat: String {
    case hourMinute = "a h:mm"
    case hourMinuteDate = "a h:mm (M/d)"
    case yyyyMMddEEEE = "yyyy. MM. dd. EEEE"
    case month = "M"
    case day = "d"
    case week = "E"
    case yearAndMonth = "yyyy년 M월"
}
