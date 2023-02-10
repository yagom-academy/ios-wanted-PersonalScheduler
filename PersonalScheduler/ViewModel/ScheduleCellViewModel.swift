//
//  ScheduleCellViewModel.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 2023/02/08.
//

import Foundation

struct ScheduleCellViewModel {

    let title: String
    let date: String
    let plannedTime: String
    let detail: String
    let uuid: UUID

    init(event: Event) {
        self.title = event.title
        self.date = event.date.convertSlashFormatString()
        self.plannedTime = "\(event.startHour)시 - \(event.endHour)시"
        self.detail = event.detail
        self.uuid = event.uuid
    }
}
