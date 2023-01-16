//
//  DateManager.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/12.
//

import Foundation

final class DateManager {
    static let shared = DateManager()
    private let dateFormatter = DateFormatter()
    private let calendar = Calendar.current
    
    private init() {
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH:mm"
    }
    
    func convert(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    func convert(text: String) -> Date? {
        return dateFormatter.date(from: text)
    }
    
    func isToday(date: Date?) -> Bool {
        guard let date = date else { return false }
        let today = Date()
        return calendar.isDate(date, inSameDayAs: today)
    }
    
    func isBetween(startDate: Date?, endDate: Date?) -> Bool {
        guard let startDate = startDate,
              let endDate = endDate else { return false }
        let today = Date()
        if today.compare(startDate) == .orderedDescending &&
            today.compare(endDate) == .orderedAscending {
            return true
        } else {
            return false
        }
    }
    
    func sortAscend(a: Date?, b: Date?) -> Bool {
        guard let startDate = a,
              let endDate = b else { return false }
        if startDate.compare(endDate) == .orderedAscending {
            return true
        } else {
            return false
        }
    }
    
    func sortDescend(a: Date?, b: Date?) -> Bool {
        guard let startDate = a,
              let endDate = b else { return false }
        if startDate.compare(endDate) == .orderedDescending {
            return true
        } else {
            return false
        }
    }
}
