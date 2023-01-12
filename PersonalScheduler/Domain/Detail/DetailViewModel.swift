//
//  AddViewModel.swift
//  PersonalScheduler
//
//  Created by 우롱차 on 2023/01/12.
//

import Foundation

enum DetailMode {
    case edit
    case add
}

protocol DetailViewModelInput {
    func save(schedule: Schedule)
}

protocol DetailViewModelOutput {
    var currentMode: Observable<DetailMode> { get }
    var errorMessage: Observable<String?> { get }
    var currentSchedule: Observable<Schedule?> { get }
    var userId: String { get }
}

protocol DetailViewModelAble: DetailViewModelInput, DetailViewModelOutput {}

final class DetailViewModel: DetailViewModelAble {
    
    private var firebaseManager: FirebaseManagerable
    var currentSchedule: Observable<Schedule?>
    var currentMode: Observable<DetailMode>
    var errorMessage: Observable<String?>
    let userId: String
    init(
        mode: DetailMode,
        firebaseManager: FirebaseManagerable = FirebaseManager.shared,
        schedule: Schedule? = nil,
        userId: String
    ) {
        self.firebaseManager = firebaseManager
        self.currentSchedule = Observable.init(schedule)
        self.currentMode = .init(mode)
        self.userId = userId
        self.errorMessage = .init(nil)
    }
}

// Input
extension DetailViewModel {
    func save(schedule: Schedule) {
        guard validationCheck(schedule: schedule) else {
            return
        }
        do {
            switch currentMode.value {
            case .add:
                try firebaseManager.create(schedule)
            case .edit:
                try firebaseManager.update(updatedData: schedule)
            }
        } catch {
            errorMessage.value = error.localizedDescription
        }
    }
    
    private func validationCheck(schedule: Schedule) -> Bool {
        guard let title = schedule.title, title != "" else {
            errorMessage.value = ValidationError.titleIsEmpty.localizedDescription
            return false
        }
        guard let date = schedule.todoDate, date != "" else {
            errorMessage.value = ValidationError.dateIsEmpty.localizedDescription
            return false
        }
        
        if schedule.contents?.count ?? 0 > 500 {
            errorMessage.value = ValidationError.contentsIsTooLong.localizedDescription
            return false
        }
        return true
    }
}




