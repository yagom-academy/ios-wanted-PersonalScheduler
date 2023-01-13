//
//  ScheduleDetailViewModel.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

struct ScheduleDetailViewModelActions {
    let successSave: () -> Void
}

protocol ScheduleDetailViewModelInput {
    var currentSchedule: Schedule? { get }
    
    func saveSchedule(_ schedule: Schedule) async throws
    func editSchedule(_ scheduleModel: ScheduleModel) async throws
}

protocol ScheduleDetailViewModelOutput {}

protocol ScheduleDetailViewModel: ScheduleDetailViewModelInput, ScheduleDetailViewModelOutput {}

final class DefaultScheduleDetailViewModel: ScheduleDetailViewModel {
    private let fireStoreManager: FireStoreManager
    private(set) var currentSchedule: Schedule?
    
    init(currentSchedule: Schedule? = nil, fireStoreCollectionId: String) {
        self.currentSchedule = currentSchedule
        self.fireStoreManager = FireStoreManager(fireStoreCollectionId: fireStoreCollectionId)
    }
    
    func saveSchedule(_ schedule: Schedule) async throws {
        try await fireStoreManager.create(schedule)
    }
    
    func editSchedule(_ scheduleModel: ScheduleModel) async throws {
        guard let currentSchedule = currentSchedule else { return }
        try await fireStoreManager.update(currentSchedule, to: scheduleModel)
    }
}
