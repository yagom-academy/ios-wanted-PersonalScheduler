//
//  SaveScheduleUseCase.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/13.
//

import Foundation

final class SaveScheduleUseCase {
    private let repository: ScheduleMakingRepositoryInterface

    init(repository: ScheduleMakingRepositoryInterface) {
        self.repository = repository
    }

    func execute(schedule: Schedule, completion: @escaping (Result<Void, Error>) -> Void) {
        repository.saveScheduleUseCase(schedule: schedule) { result in
            completion(result)
        }
    }
}
