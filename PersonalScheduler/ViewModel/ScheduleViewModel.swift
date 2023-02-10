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

    func removeEvent(of uuid: UUID) {
        guard let event = events.value.filter({ $0.uuid == uuid }).first,
              let index = events.value.firstIndex(of: event) else { return }

        events.value.remove(at: index)
        FirebaseManager(collectionName: userId).delete(event)
    }
}
