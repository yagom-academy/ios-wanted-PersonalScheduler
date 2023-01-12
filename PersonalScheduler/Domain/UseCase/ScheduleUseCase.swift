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
    
    func addSchedule(_ schedule: ScheduleInfo) async throws {
        try await fireStoreScehduleRepository.addSchedule(schedule)
    }
    
    func deleteSchedule(_ schedule: ScheduleInfo) async throws {
        try await fireStoreScehduleRepository.deleteSchedule(schedule)
    }
}
