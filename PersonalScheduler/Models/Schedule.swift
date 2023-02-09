//
//  Schedule.swift
//  PersonalScheduler
//
//  Created by junho lee on 2023/02/09.
//

import Foundation

struct Schedule: Identifiable, Equatable {
    let id: UUID
    var title: String
    var scheduleDate: Date
    var body: String

    init(
        id: UUID = UUID(),
        title: String = String(),
        scheduleDate: Date = Date(),
        body: String = String()
    ) {
        self.id = id
        self.title = title
        self.scheduleDate = scheduleDate
        self.body = body
    }
}
