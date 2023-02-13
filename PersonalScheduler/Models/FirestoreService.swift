//
//  FirestoreService.swift
//  PersonalScheduler
//
//  Created by junho lee on 2023/02/09.
//

import Foundation

final class FirestoreService {
    private let firestoreRepository: FirestoreRepository<ScheduleEntity>

    init(collection: String) {
        firestoreRepository = FirestoreRepository<ScheduleEntity>(collection: collection)
    }

    func fetchAll(completion: @escaping ([Schedule]) -> Void) {
        firestoreRepository.fetchAll { [weak self] scheduleEntities in
            guard let self else { return }
            let schedules = scheduleEntities.map { scheduleEntity in
                return self.schedule(from: scheduleEntity)
            }
            completion(schedules)
        }
    }

    func add(_ schedule: Schedule) {
        let scheduleEntity = scheduleEntity(from: schedule)
        firestoreRepository.add(scheduleEntity)
    }

    func update(_ schedule: Schedule) {
        let scheduleEntity = scheduleEntity(from: schedule)
        firestoreRepository.update(scheduleEntity)

    }

    func delete(_ schedule: Schedule) {
        let scheduleEntity = scheduleEntity(from: schedule)
        firestoreRepository.delete(scheduleEntity)
    }

    private func scheduleEntity(from schedule: Schedule) -> ScheduleEntity {
        return ScheduleEntity(
            id: schedule.id,
            title: schedule.title,
            scheduleDate: schedule.scheduleDate,
            body: schedule.body
        )
    }

    private func schedule(from scheduleEntity: ScheduleEntity) -> Schedule {
        return Schedule(
            id: scheduleEntity.id,
            title: scheduleEntity.title,
            scheduleDate: scheduleEntity.scheduleDate,
            body: scheduleEntity.body
        )
    }
}
