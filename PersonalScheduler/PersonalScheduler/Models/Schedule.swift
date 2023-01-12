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

enum Status {
    case planned
    case done
}
