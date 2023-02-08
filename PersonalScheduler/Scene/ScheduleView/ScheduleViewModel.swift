//
//  ScheduleViewModel.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/08.
//

import Foundation

protocol ScheduleViewModelDelegate: AnyObject {
    func scheduleViewModel(didChange schedules: [Schedule])
    func scheduleViewModel(selectedScheduleID id: String)
    func scheduleViewModel(failedFetchData error: RemoteDBError)
}
