//
//  ScheduleViewModel.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/08.
//

import Foundation

protocol ScheduleViewModelDelegate: AnyObject {
    func scheduleViewModel(didChange startDateWithSchedules: [String: [SchedulePreview]])
    func scheduleViewModel(selectedScheduleID id: String)
    func scheduleViewModel(failedFetchData error: RemoteDBError)
}

final class ScheduleViewModel {
    enum Action {
        case viewWillAppear
        case tapSchedule(section: String, index: Int)
        case findSectionTitle(section: Int, completion: ((String) -> Void))
        case tapLogout
    }
    
    private let userID: String
    private let scheduleservice: ScheduleServiceable
    private let loginService: LoginService
    weak var delegate: ScheduleViewModelDelegate?
    
    private var periodWithSchedules: [String: [SchedulePreview]] = [:] {
        didSet {
            delegate?.scheduleViewModel(didChange: periodWithSchedules)
        }
    }
    
    init(userID: String, scheduleservice: ScheduleServiceable, loginService: LoginService) {
        self.userID = userID
        self.scheduleservice = scheduleservice
        self.loginService = loginService
    }
    
    func action(_ action: Action) {
        switch action {
        case .viewWillAppear:
            setInitialSchedules()
        case .tapSchedule(let section, let index):
            tapScheduleCell(section: section, index: index)
        case .findSectionTitle(let section, let completion):
            findSectionTitle(from: section, completion: completion)
        case .tapLogout:
            loginService.requestLogout { _ in }
        }
    }
    
    private func setInitialSchedules() {
        scheduleservice.requestAllSchedule(from: userID) { [weak self] result in
            switch result {
            case .success(let schedules):
                var result: [String: [SchedulePreview]] = [:]
                let schedulePreviews = schedules .map { $0.convertForViewModel() }
                let keys = schedulePreviews.map { $0.startDateString }.uniqued()
                
                keys.forEach { key in
                    result[key] = schedulePreviews.filter { $0.startDateString == key }
                }
                
                self?.periodWithSchedules = result
            case .failure(let error):
                self?.delegate?.scheduleViewModel(failedFetchData: error)
            }
        }
    }
    
    private func tapScheduleCell(section: String, index: Int) {
        guard let selectedSchedule = periodWithSchedules[section]?[index] else { return }
        
        delegate?.scheduleViewModel(selectedScheduleID: selectedSchedule.id)
    }
    
    func findSectionTitle(from section: Int, completion: ((String) -> Void)) {
        let keys = periodWithSchedules.keys.sorted(by: >)
        
        completion(keys[section])
    }
}
