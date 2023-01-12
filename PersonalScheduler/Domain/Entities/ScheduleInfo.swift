//
//  ScheduleInfo.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/12.
//

import Foundation

struct ScheduleInfo: Decodable {
    let title: String
    let startTime: Date
    let content: String
}
