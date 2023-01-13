//
//  ScheduleListViewModel.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/12.
//

import Foundation

enum MainSection {
  case main
}

protocol ScheduleListViewModelInput {
    func loadItems()
    func deleteItem(index: Int)
}

protocol ScheduleListViewModelOutput {
    var items: Observable<[ScheduleInfo]> { get }
    var isloading: Observable<Bool> { get }
    var error: Observable<String?> { get }
}

protocol ScheduleListViewModelType: ScheduleListViewModelInput, ScheduleListViewModelOutput { }

final class ScheduleListViewModel: ScheduleListViewModelType {
    
    let scheduleUseCase = ScheduleUseCase()
    
    private var fetchScheduleTask: Task<Void, Error>?
    private var deleteScheduleTask: Task<Void, Error>?
    
    var count = 10
    var offset = 0
    
    /// Output
    
    var items: Observable<[ScheduleInfo]> = Observable([])
    var isloading: Observable<Bool> = Observable(false)
    var error: Observable<String?> = Observable(nil)
    
    /// Input
    
    func loadItems() {
        isloading.value = true
        
        self.fetchScheduleTask = Task {
            do {
                let schduleList = try await scheduleUseCase.getScheduleList()
                items.value = schduleList
                isloading.value = false
            }
            catch {
                self.error.value = error.localizedDescription
            }
        }
        fetchScheduleTask?.cancel()
    }
    
    func deleteItem(index: Int) {
        self.fetchScheduleTask = Task {
            do {
                try await scheduleUseCase.deleteSchedule(items.value[index])
                self.loadItems()
            }
            catch {
                self.error.value = error.localizedDescription
            }
        }
        fetchScheduleTask?.cancel()
    }
    
}
