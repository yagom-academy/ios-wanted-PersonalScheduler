//
//  ScheduleUseCase.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/12.
//

import Foundation

final class ScheduleUseCase {
    let fireStoreScehduleRepository = FireStoreScehduleRepository()
    
    func getScheduleList() async throws -> [ScheduleInfo] {
        try await fireStoreScehduleRepository.fetchScheduleList()
    }
}
