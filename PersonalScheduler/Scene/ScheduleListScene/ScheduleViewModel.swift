//
//  ScheduleViewModel.swift
//  PersonalScheduler
//
//  Created by Judy on 2023/01/10.
//

import Foundation

protocol ScheduleViewModelInput {
    func save(_ schedule: Schedule, at userID: String)
    func fetch(at userID: String)
    func delete(_ schedule: Schedule, at userID: String)
}

protocol ScheduleViewModelOutput {
    var schedules: Observable<[Schedule]> { get set }
    var sections: Observable<[String]> { get set }
    var error: Observable<String?> { get set }
}

protocol ScheduleViewModelType: ScheduleViewModelInput, ScheduleViewModelOutput { }

final class ScheduleViewModel: ScheduleViewModelType {
    private let scheduleFirestoreUseCase = ScheduleFirestoreUseCase()
    
    /// Output
    var schedules: Observable<[Schedule]> = Observable([])
    var sections: Observable<[String]> = Observable([])
    var error: Observable<String?> = Observable(nil)
    
    /// Input
    func save(_ schedule: Schedule, at userID: String) {
        scheduleFirestoreUseCase.save(schedule, at: userID) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                self.error.value = error.localizedDescription
            }
        }
    }
    
    func fetch(at userID: String) {
        scheduleFirestoreUseCase.fetch(at: userID) { [weak self] result in
            switch result {
            case .success(let schedules):
                self?.schedules.value = schedules
            case .failure(let error):
                self?.error.value = error.localizedDescription
            }
        }
    }
    
    func delete(_ schedule: Schedule, at userID: String) {
        scheduleFirestoreUseCase.delete(schedule, at: userID) { [weak self] result in
            switch result {
            case .success(_):
                self?.fetch(at: userID)
            case .failure(let error):
                self?.error.value = error.localizedDescription
            }
        }
    }
}
