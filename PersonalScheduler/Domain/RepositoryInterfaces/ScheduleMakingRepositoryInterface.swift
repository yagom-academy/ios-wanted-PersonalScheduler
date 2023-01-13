//
//  ScheduleMakingRepositoryInterface.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/13.
//

import Foundation

protocol ScheduleMakingRepositoryInterface {
    func saveScheduleUseCase(schedule: Schedule, completion: @escaping (Result<Void, Error>) -> Void)
}
