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

extension ScheduleDTO {
    func toEntity() -> Schedule {
        let schedule = Schedule(
            id: self.id,
            title: self.title,
            description: self.description,
            startMoment: self.startMoment.toDate(),
            endMoment: self.endMoment.toDate(),
            status: Status(rawValue: self.status) ?? .planned
        )
        
        return schedule
    }
}

fileprivate extension String {
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm Z"
        guard let date = formatter.date(from: self) else {
            return Date()
        }
        
        return date
    }
}
