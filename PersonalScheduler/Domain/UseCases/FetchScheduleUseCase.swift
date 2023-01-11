//
//  FetchScheduleUseCase.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/11.
//

import Foundation

final class FetchScheduleUseCase {

    private let repository: ScheduleListRepositoryInterface

    init(repository: ScheduleListRepositoryInterface) {
        self.repository = repository
    }

    func execute(for date: Date, completion: @escaping (Result<[Schedule], Error>) -> Void) {
        repository.fetchSchedule(for: date) { result in
            completion(result)
        }
    }
}
