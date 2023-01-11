//
//  ScheduleRepository.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import Foundation
import Combine

protocol ScheduleRepository {
    func read() -> AnyPublisher<[Schedule], Error>
    func write(schedule: Schedule) -> AnyPublisher<Bool, Error>
    func delete(schedule: Schedule)
    func update(schedule: Schedule) -> AnyPublisher<Bool, Error>
}

final class DefaultScheduleRepository: ScheduleRepository {
    
    private let firestoreStorage: FirestoreStorageService
    private let localStorage: LocalStorageService
    
    init(
        firestoreStorage: FirestoreStorageService = FirestoreStorage.shared,
        localStorage: LocalStorageService = UserDefaults.standard
    ) {
        self.firestoreStorage = firestoreStorage
        self.localStorage = localStorage
    }
    
    func read() -> AnyPublisher<[Schedule], Error> {
        guard let user = localStorage.getUser() else {
            return Empty().eraseToAnyPublisher()
        }
        return firestoreStorage.read(userID: user.userID)
            .map { $0.schedules?.sorted { $0.startDate < $1.startDate } ?? [] }
            .eraseToAnyPublisher()
    }
    
    func write(schedule: Schedule) -> AnyPublisher<Bool, Error> {
        guard var user = localStorage.getUser() else {
            return Empty().eraseToAnyPublisher()
        }
        var newSchedules: [Schedule] = user.schedules ?? []
        newSchedules.append(schedule)
        user.schedules = newSchedules
        localStorage.saveUser(user)
        return firestoreStorage.write(user: user)
    }
    
    func delete(schedule: Schedule) {
        guard var user = localStorage.getUser() else {
            return
        }
        let schedules: [Schedule] = user.schedules?.filter { $0 != schedule } ?? []
        user.schedules = schedules
        localStorage.saveUser(user)
        firestoreStorage.delete(user: user)
    }
    
    func update(schedule: Schedule) -> AnyPublisher<Bool, Error> {
        guard var user = localStorage.getUser(),
              let index = user.schedules?.firstIndex(of: schedule)
        else {
            return Empty().eraseToAnyPublisher()
        }
        var newSchedules: [Schedule] = user.schedules ?? []
        newSchedules[index] = schedule
        user.schedules = newSchedules
        localStorage.saveUser(user)
        return firestoreStorage.update(user: user)
    }
}
