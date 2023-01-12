//
//  Schedule.swift
//  PersonalScheduler
//
//  Created by minsson on 2023/01/12.
//

import Foundation

struct Schedule {
    var id: String
    var title: String
    var description: String
    var startMoment: Date
    var endMoment: Date
    var status: Status
}

extension Schedule {
    func toScheduleDTO() -> ScheduleDTO {
        let scheduleDTO = ScheduleDTO(
            id: self.id,
            title: self.title,
            description: self.description,
            startMoment: self.startMoment.toString(),
            endMoment: self.endMoment.toString(),
            status: self.status.description
        )
        
        return scheduleDTO
    }
}

enum Status {
    case planned
    case done
    
    var description: String {
        switch self {
        case .planned:
            return "planned"
        case .done:
            return "done"
        }
    }
}

fileprivate extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: self)
    }
}
