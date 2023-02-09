//
//  ScheduleViewModel.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 2023/02/09.
//

import Foundation

final class ScheduleViewModel {

    private let events: Observable<[Event]> = Observable([])

    func bind(closure: @escaping ([Event]) -> Void) {
        events.bind(closure)
    }
}
