//
//  ScheduleInfo.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/12.
//

import Foundation

struct ScheduleInfo: Decodable, Hashable {
    let id: String
    let title: String
    let time: TimeInterval
    let content: String
    
    var dictionary: [String: Any] {
        return["id": id,
                "title": title,
                "time": time,
                "content": content]
    }
}
