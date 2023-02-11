//
//  ScheduleCellViewModel.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 2023/02/08.
//

import Foundation

struct ScheduleCellViewModel {

    private let event: Event
    var title: String? { return event.title }
    var date: String { return event.date.convertSlashFormatString() }
    var description: String? { return event.description }
    var uuid: UUID { return event.uuid }
    var plannedTime: String {
        let startTimeString = event.startTime.convertToTimeString()
        let endTimeString  = event.endTime.convertToTimeString()
        return  "\(startTimeString) ~ \(endTimeString)"
    }

    init(event: Event) {
        self.event = event
    }
}
