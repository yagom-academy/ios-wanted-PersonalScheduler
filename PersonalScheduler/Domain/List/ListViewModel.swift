//
//  ListViewModel.swift
//  PersonalScheduler
//
//  Created by 우롱차 on 2023/01/12.
//

import Foundation

protocol ListViewModelInput {
    func loadSchedules()
    func deleteSchedule(schedule: Schedule)
}

protocol ListViewModelOutput {
    var scheduls: Observable<[Schedule]?> { get }
    var errorMessage: Observable<String?> { get }
    var detailScheduls: Observable<Schedule?> { get }
    var userId: String { get }
}

protocol ListViewModelAble: ListViewModelInput, ListViewModelOutput {}

class ListViewModel: ListViewModelAble {
    
    var scheduls: Observable<[Schedule]?>
    var errorMessage: Observable<String?>
    var detailScheduls: Observable<Schedule?>
    
    private var scheduleManager: SchedulManagerAble
    let userId: String
    
    init(userId: String, scheduleManager: SchedulManagerAble = SchedulManager()){
        self.userId = userId
        self.scheduleManager = scheduleManager
        scheduls = .init(nil)
        errorMessage = .init(nil)
        detailScheduls = .init(nil)
        loadSchedules()
    }
}

// MARK - input
extension ListViewModel {
    
    func deleteSchedule(schedule: Schedule) {
        
    }
    
    func loadSchedules() {
        scheduleManager.loadSchedule(userId: userId).observe(on: self) { [weak self] result in
            switch result {
            case .success(let schedulArray):
                self?.scheduls.value = schedulArray
            case .failure(let error):
                self?.errorMessage.value = error.localizedDescription
            case .none:
                return
            }
        }
    }
}
