//
//  ScheduleListCoordinatorInterface.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import Foundation

protocol ScheduleListCoordinatorInterface: AnyObject {
    
    func showCreateSchedule()
    func showEditSchedule(_ schedule: Schedule)
    func finished()
    
}
