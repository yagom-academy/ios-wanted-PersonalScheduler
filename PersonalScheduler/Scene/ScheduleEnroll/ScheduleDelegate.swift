//
//  ScheduleDelegate.swift
//  PersonalScheduler
//
//  Created by bard on 2023/01/13.
//

protocol ScheduleDelegate: AnyObject {
    func appendSchedule(_ schedule: Schedule)
}
