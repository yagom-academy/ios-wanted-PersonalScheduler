//
//  ScheduleListViewModel.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/12.
//

import Foundation

protocol ScheduleListViewModelInput {
    func loadItems()
    func deleteItem(information: ScheduleInfo)
}

protocol ScheduleListViewModelOutput {
    var items: Observable<[ScheduleInfo]> { get }
    var isloading: Observable<Bool> { get }
    var error: Observable<String?> { get }
}

protocol ScheduleListViewModelType: ScheduleListViewModelInput, ScheduleListViewModelOutput { }

final class ScheduleListViewModel: ScheduleListViewModelType {
    let scheduleUseCase = ScheduleUseCase()
    
    var count = 10
    var offset = 0
    
    /// Output
    
    var items: Observable<[ScheduleInfo]> = Observable([])
    var isloading: Observable<Bool> = Observable(false)
    var error: Observable<String?> = Observable(nil)
    
    /// Input
    
    func loadItems() {
        offset = 0
        appendItems()
    }
    
    func deleteItem(information: ScheduleInfo) {
        
        
    }
    
    func appendItems() {
        isloading.value = true
        DispatchQueue.global().async {
//            guard let motionData = self.motionCoreDataUseCase.fetch(offset: self.offset, count: self.count) else { return }
            self.offset = self.count
//            self.items.value = motionData
            self.isloading.value = false
        }
    }
    
}
