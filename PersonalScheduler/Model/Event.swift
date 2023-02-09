//
//  Event.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 2023/02/08.
//

import Foundation

struct Event: Hashable {

    let title: String
    let date: Date
    let startHour: Int
    let endHour: Int
    let detail: String
    let uuid: UUID
}
