//
//  ScheduleList.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/09.
//

import Foundation

struct ScheduleList: Identifiable {
    var id = UUID().uuidString
    var title: String = ""
    var description: String = ""
    var startTimeStamp: Date = Date()
    var endTimeStamp: Date = Date()
    
    var dictionary: [String: Any] {
        return [
            "id": id,
            "title": title,
            "description": description,
            "startTimeStamp": startTimeStamp,
            "endTimeStamp": endTimeStamp
        ]
    }
}
