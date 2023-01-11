//
//  DeleteScheduleUseCase.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/11.
//

import Foundation

final class DeleteScheduleUseCase {
    private let repository: ScheduleListRepositoryInterface

    init(repository: ScheduleListRepositoryInterface) {
        self.repository = repository
    }

    func execute(id: UUID, completion: @escaping (Result<Void, Error>) -> Void) {
        repository.deleteSchedule(id: id) { result in
            completion(result)
        }
    }
}
