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

final class ScheduleViewModel {
    enum Action {
        case viewWillAppear
        case tapSchedule(indexPath: IndexPath)
    }
    
    private let userID: String
    private let service: ScheduleServiceable
    private weak var delegate: ScheduleViewModelDelegate?
    
    private var schedules: [Schedule] = [] {
    }
    
    init(userID: String, service: ScheduleServiceable) {
        self.userID = userID
        self.service = service
    }
}
