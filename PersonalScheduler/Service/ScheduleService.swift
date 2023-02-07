//
//  ScheduleService.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/07.
//

import Foundation

final class ScheduleService {
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func requestAllSchedule(from userID: String, completion: @escaping ((Result<[Schedule], RemoteDBError>) -> Void)) {
        repository.readAll(from: userID) { result in
            switch result {
            case .success(let schedules):
                completion(.success(schedules.map { $0.asDomain() }))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func requestSchedule(
        from userID: String,
        at documentID: String,
        completion: @escaping ((Result<Schedule, RemoteDBError>) -> Void)
    ) {
        repository.read(from: userID, documentID: documentID) { result in
            switch result {
            case .success(let schedule):
                completion(.success(schedule.asDomain()))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func requestScheduleUpdate(
        from userID: String,
        at schedule: Schedule,
        completion: @escaping ((Result<Void, RemoteDBError>) -> Void)
    ) {
        repository.update(from: userID, at: schedule) { result in
            switch result {
            case .success():
                completion(.success(()))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func requestScheduleCreate(
        from userID: String,
        at schedule: Schedule,
        completion: @escaping ((Result<Void, RemoteDBError>) -> Void)
    ) {
        repository.create(from: userID, at: schedule) { result in
            switch result {
            case .success():
                completion(.success(()))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func requestScheduleDelete(
        from userID: String,
        at schedule: Schedule,
        completion: @escaping ((Result<Void, RemoteDBError>) -> Void)
    ) {
        repository.delete(from: userID, at: schedule) { result in
            switch result {
            case .success():
                completion(.success(()))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
