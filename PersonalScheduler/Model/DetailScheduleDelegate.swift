//
//  DetailScheduleDelegate.swift
//  PersonalScheduler
//
//  Created by Mangdi on 2023/02/09.
//

import Foundation

protocol DetailScheduleDelegate: AnyObject {
    func createSchedule(data: ScheduleModel)
    func updateSchedule(data: ScheduleModel)
}
