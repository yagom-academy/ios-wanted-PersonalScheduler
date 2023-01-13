//
//  ScheduleUseCase.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/12.
//

import Foundation

final class ScheduleUseCase {
    let fireStoreScehduleRepository = FireStoreRepository()
    let keychainRepository: KeyChainRepository = KeyChainRepository()
    
    func getScheduleList() async throws -> [ScheduleInfo] {
        let userId = try await keychainRepository.getUserId()
        return try await fireStoreScehduleRepository.fetchScheduleList(userId: userId)
    }
    
    func addSchedule(_ schedule: ScheduleInfo) async throws {
        let userId = try await keychainRepository.getUserId()
        try await fireStoreScehduleRepository.addSchedule(userId: userId, schedule)
    }
    
    func updateSchedule(previousScehdule: ScheduleInfo, to newSchedule: ScheduleInfo) async throws {
        let userId = try await keychainRepository.getUserId()
        try await fireStoreScehduleRepository.deleteSchedule(userId: userId, previousScehdule)
        try await fireStoreScehduleRepository.addSchedule(userId: userId, newSchedule)
    }
    
    func deleteSchedule(_ schedule: ScheduleInfo) async throws {
        let userId = try await keychainRepository.getUserId()
        try await fireStoreScehduleRepository.deleteSchedule(userId: userId, schedule)
    }
}
