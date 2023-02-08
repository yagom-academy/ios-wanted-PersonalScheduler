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
        didSet {
            delegate?.scheduleViewModel(didChange: schedules)
        }
    }
    
    init(userID: String, service: ScheduleServiceable) {
        self.userID = userID
        self.service = service
    }
    
    func action(_ action: Action) {
        switch action {
        case .viewWillAppear:
            setInitialSchedules()
        case .tapSchedule(let indexPath):
            tapScheduleCell(indexPath: indexPath)
        }
    }
    
    private func setInitialSchedules() {
        service.requestAllSchedule(from: userID) { [weak self] result in
            switch result {
            case .success(let schedules):
                self?.schedules = schedules
            case .failure(let error):
                self?.delegate?.scheduleViewModel(failedFetchData: error)
            }
        }
    }
    
    private func tapScheduleCell(indexPath: IndexPath) {
        let selectedSchedule = schedules[indexPath.row]
        
        delegate?.scheduleViewModel(selectedScheduleID: selectedSchedule.id)
    }
}
