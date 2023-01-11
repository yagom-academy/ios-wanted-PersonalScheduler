//
//  ScheduleListRepositoryInterface.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/11.
//

import Foundation

protocol ScheduleListRepositoryInterface {
    func fetchSchedule(for date: Date, completion: @escaping (Result<[Schedule], Error>) -> Void)
}
