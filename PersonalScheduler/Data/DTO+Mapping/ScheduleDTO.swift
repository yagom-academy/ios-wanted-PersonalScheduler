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
        case scheduleId
        case uid
        case title
        case description
        case startDate
        case endDate
    }
}

extension ScheduleDTO {
    func toDomain() -> Schedule {
        guard let scheduleId = scheduleData[Keys.scheduleId.rawValue] as? String,
              let uuid = UUID(uuidString: scheduleId),
              let title = scheduleData[Keys.title.rawValue] as? String,
              let description = scheduleData[Keys.description.rawValue] as? String,
              let startTimeStamp = scheduleData[Keys.startDate.rawValue] as? Timestamp,
              let endTimeStamp = scheduleData[Keys.endDate.rawValue] as? Timestamp else {
            return Schedule(id: UUID(), title: "", description: "", startDate: Date(), endDate: Date())
        }

        let startDate = startTimeStamp.dateValue()
        let endDate = endTimeStamp.dateValue()

        return Schedule(id: uuid, title: title, description: description, startDate: startDate, endDate: endDate)
    }
}

extension Schedule {
    func toDTO() -> ScheduleDTO {
        guard let uid = Auth.auth().currentUser?.uid else { return ScheduleDTO(scheduleData: [:]) }
        var scheduleDictionary = [String: Any]()
        scheduleDictionary.updateValue(uid, forKey: "uid")
        scheduleDictionary.updateValue(id.uuidString, forKey: "scheduleId")
        scheduleDictionary.updateValue(title, forKey: "title")
        scheduleDictionary.updateValue(description, forKey: "description")
        scheduleDictionary.updateValue(startDate, forKey: "startDate")
        scheduleDictionary.updateValue(endDate, forKey: "endDate")

        return ScheduleDTO(scheduleData: scheduleDictionary)
    }
}
