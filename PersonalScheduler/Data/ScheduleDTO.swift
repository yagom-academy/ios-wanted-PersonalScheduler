//
//  ScheduleDTO.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/12.
//

import Foundation
import Firebase

struct ScheduleDTO {
    let scheduleData: [String: Any]

    enum Keys: String, CaseIterable {
        case uid
        case title
        case description
        case startDate
        case endDate
    }
}

extension ScheduleDTO {
    func toDomain() -> Schedule {
        guard let title = scheduleData[Keys.title.rawValue] as? String,
              let description = scheduleData[Keys.description.rawValue] as? String,
              let startDate = scheduleData[Keys.startDate.rawValue] as? Date,
              let endDate = scheduleData[Keys.endDate.rawValue] as? Date else {
            return Schedule(id: UUID(), title: "", description: "", startDate: Date(), endDate: Date())
        }

        return Schedule(id: UUID(), title: title, description: description, startDate: startDate, endDate: endDate)
    }
}

extension Schedule {
    func toDTO() -> ScheduleDTO {
        var scheduleDictionary = [String: Any]()
        scheduleDictionary.updateValue("user id 받아와야 함", forKey: "uid") // TODO: uid 여기서 넣어주기
        scheduleDictionary.updateValue(title, forKey: "title")
        scheduleDictionary.updateValue(description, forKey: "description")
        scheduleDictionary.updateValue(startDate, forKey: "startDate")
        scheduleDictionary.updateValue(endDate, forKey: "endDate")

        return ScheduleDTO(scheduleData: scheduleDictionary)
    }
}
