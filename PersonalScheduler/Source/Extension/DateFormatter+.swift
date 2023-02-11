//  PersonalScheduler - DateFormatter+.swift
//  Created by zhilly on 2023/02/11

import Foundation

extension DateFormatter {
    
    static func convertToString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH:mm"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        return dateFormatter.string(from: date)
    }
    
    static func convertToPeriod(start: Date?, end: Date?) -> String {
        var startDate: String = .init()
        var endDate: String = .init()
        
        if let start = start {
            startDate = convertToString(from: start)
        }
        
        if let end = end {
            endDate = convertToString(from: end)
        }
        
        return startDate + " ~ " + endDate
    }
}
