//
//  User.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/12.
//

import Foundation

struct User: Decodable {
    let userId: String
    let schedules: [ScheduleInfo]
}
