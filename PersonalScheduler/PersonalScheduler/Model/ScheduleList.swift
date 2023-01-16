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
    var startTimeStamp: String = ""
    var endTimeStamp: String = ""
    
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
