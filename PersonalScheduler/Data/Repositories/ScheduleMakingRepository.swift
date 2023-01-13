//
//  ScheduleMakingRepository.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/13.
//

import Foundation

final class ScheduleMakingRepository: ScheduleMakingRepositoryInterface {

    private let firebaseService = FirebaseService.shared

    func saveScheduleUseCase(schedule: Schedule, completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseService.saveSchedule(schedule: schedule) { result in
            completion(result)
        }
    }
}
