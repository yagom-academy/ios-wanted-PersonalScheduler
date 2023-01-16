//
//  FireStoreRepository.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/13.
//

import Foundation

protocol FireStoreRepository {
    func fetchScheduleList(userId: String) async throws -> [ScheduleInfo]
    func addSchedule(userId: String, _ schedule: ScheduleInfo) async throws
    func deleteSchedule(userId: String, _ schedule: ScheduleInfo) async throws
    func setUserData(userId: String) async throws
}
