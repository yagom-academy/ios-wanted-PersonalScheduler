//
//  ScheduleModel.swift
//  PersonalScheduler
//
//  Created by Mangdi on 2023/02/09.
//

import Foundation

struct ScheduleModel: Identifiable {
    let id: UUID
    var title, body, date: String

    init(id: UUID = UUID(), title: String, body: String, date: String) {
        self.id = id
        self.title = title
        self.body = body
        self.date = date
    }
}
