//
//  RegisterViewModel.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 2023/02/11.
//

import Foundation

final class RegisterViewModel {

    enum State {
        case new
        case modification
    }

    private(set) var state: State
    private let event: Event

    var newStateTitle: String { return "Add new event" }
    var modificationStateTitle: String { return "Modify event" }
    var startLabelText: String { return  "Start" }
    var endLabelText: String { return "End" }
    var titleFieldPlaceHolder: String { return  "Title" }
    var title: String? { return event.title }
    var date: Date { return event.date }
    var startTime: Date { return event.startTime }
    var endTime: Date { return event.endTime }
    var description: String? { return event.description }
    var uuid:UUID { return event.uuid }

    init(event: Event) {
        self.state = .modification
        self.event = event
    }

    init() {
        self.state = .new
        self.event = Event(title: nil,
                           date: Date(),
                           startTime: Date() ,
                           endTime: Date(),
                           description: nil,
                           uuid: UUID())
    }
}
