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
                .init(id: UUID(), title: "첫번째 제목", description: "첫번째 내용", startDate: Date(timeIntervalSinceNow: -10000), endDate: Date(timeIntervalSinceNow: 10000)),
                .init(id: UUID(), title: "두번째 제목", description: "두번째 내용 가끔 이렇게 긴 내용도 추가될 수 있어서 두줄이 아니라 세줄까지도 길이가 늘어날수도 있습니다. 터치하면 셀이 늘어났다가 다시 터치하면 셀이 줄어들기에 큰 문제 없이 일정의 내용을 확인할수도 있습니다. 아무쪼록 잘 쓰시고 좋은 평점 남겨주시면 감사하겠습니다.", startDate: Date(timeIntervalSinceNow: 100), endDate: Date(timeIntervalSinceNow: 10000)),
                .init(id: UUID(), title: "세번째 제목", description: "세번째 내용", startDate: Date(), endDate: Date()),
                .init(id: UUID(), title: "네번째 제목", description: "네번째 내용", startDate: Date(), endDate: Date())
            ]))
        }
    }

    func deleteSchedule(id: UUID, completion: @escaping (Result<Void, Error>) -> Void) {
        completion(.success(()))
    }
}
