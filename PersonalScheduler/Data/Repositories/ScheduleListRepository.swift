//
//  File.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/12.
//

import Foundation

final class ScheduleListRepository: ScheduleListRepositoryInterface {
    private let firebaseService = FirebaseService.shared

    func fetchSchedule(for date: Date, completion: @escaping (Result<[Schedule], Error>) -> Void) {
        firebaseService.fetchSchedules(for: date) { result in
            switch result {
            case .success(let dto):
                completion(.success(dto.map{ $0.toDomain() }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func deleteSchedule(id: UUID, completion: @escaping (Result<Void, Error>) -> Void) {
        
    }
}
