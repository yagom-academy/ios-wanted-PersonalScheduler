//
//  ScheduleViewModel.swift
//  PersonalScheduler
//
//  Created by Judy on 2023/01/10.
//

import Foundation

protocol ScheduleViewModelInput {
    func save(_ schedule: Schedule)
    func fetch()
    func delete(_ schedule: Schedule)
}

protocol ScheduleViewModelOutput {
    var schedules: Observable<[Schedule]> { get set }
    var sections: Observable<[String]> { get set }
    var error: Observable<String?> { get set }
}

protocol ScheduleViewModelType: ScheduleViewModelInput, ScheduleViewModelOutput { }

final class ScheduleViewModel: ScheduleViewModelType {
    private let scheduleFirestoreUseCase = ScheduleFirestoreUseCase()
    private let userToken: String
    var schedules: Observable<[Schedule]> = Observable([])
    var sections: Observable<[String]> = Observable([])
    var error: Observable<String?> = Observable(nil)
    
    init(with userToken: String) {
        self.userToken = userToken
    }
    
    func save(_ schedule: Schedule) {
        scheduleFirestoreUseCase.save(schedule, at: userToken) { [weak self] result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                self?.error.value = error.localizedDescription
            }
        }
    }
    
    func fetch() {
        scheduleFirestoreUseCase.fetch(at: userToken) { [weak self] result in
            switch result {
            case .success(let schedules):
                self?.schedules.value = schedules.sorted(by: { $0.startTime > $1.startTime } )
            case .failure(let error):
                self?.error.value = error.localizedDescription
            }
        }
    }
    
    func delete(_ schedule: Schedule) {
        scheduleFirestoreUseCase.delete(schedule, at: userToken) { [weak self] result in
            switch result {
            case .success(_):
                self?.fetch()
            case .failure(let error):
                self?.error.value = error.localizedDescription
            }
        }
    }
}
