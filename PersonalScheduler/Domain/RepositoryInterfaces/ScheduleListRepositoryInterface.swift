//
//  ScheduleListRepositoryInterface.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/11.
//

import Foundation

protocol ScheduleListRepositoryInterface {

    func fetchSchedule(for date: Date, completion: @escaping (Result<[Schedule], Error>) -> Void)
    func deleteSchedule(id: UUID, completion: @escaping (Result<Void, Error>) -> Void)
}

final class MockScheduleRepository: ScheduleListRepositoryInterface {
    func fetchSchedule(for date: Date, completion: @escaping (Result<[Schedule], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.success([
                .init(id: UUID(), title: "첫번째 제목", description: "첫번째 내용", startDate: Date(), endDate: Date()),
                .init(id: UUID(), title: "두번째 제목", description: "두번째 내용", startDate: Date(), endDate: Date()),
                .init(id: UUID(), title: "세번째 제목", description: "세번째 내용", startDate: Date(), endDate: Date()),
                .init(id: UUID(), title: "네번째 제목", description: "네번째 내용", startDate: Date(), endDate: Date())
            ]))
        }
    }

    func deleteSchedule(id: UUID, completion: @escaping (Result<Void, Error>) -> Void) {
        completion(.success(()))
    }
}
