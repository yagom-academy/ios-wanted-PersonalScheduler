//
//  Date+Extension.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import Foundation

extension Date {
    static let formatter = DateFormatter()
    
    func convertDescription() -> String {
        Self.formatter.dateFormat = "yy.MM.dd a h:mm"
        Self.formatter.locale = Locale(identifier: "ko-KR")
        Self.formatter.timeZone = TimeZone(abbreviation: "KST")
        return Self.formatter.string(from: self)
    }
}
