//
//  ScheduleViewModel.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 2023/02/09.
//

import Foundation

final class ScheduleViewModel {

    private let userId: String
    private(set) var events: Observable<[Event]> = Observable([])
    private(set) var error: Observable<Error?> = Observable(nil)

    init(userId: String) {
        self.userId = userId
    }

    func fetchEvents() {
        FirebaseManager(collectionName: userId).read { result in
            switch result {
            case .success(let events):
                self.events.value = events
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}
