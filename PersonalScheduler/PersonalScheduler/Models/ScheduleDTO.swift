//
//  ScheduleDTO.swift
//  PersonalScheduler
//
//  Created by minsson on 2023/01/12.
//

import Foundation

struct ScheduleDTO {
    var id: String
    var title: String
    var description: String
    var startMoment: String
    var endMoment: String
    var status: String
}

fileprivate extension String {
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        guard let date = formatter.date(from: self) else {
            return Date()
        }
        
        return date
    }
}
