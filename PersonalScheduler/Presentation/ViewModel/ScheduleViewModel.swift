//
//  ScheduleViewModel.swift
//  PersonalScheduler
//
//  Created by 이예은 on 2023/01/12.
//

import UIKit
import Combine
protocol ScheduleViewModelInput {
    func viewWillAppear()
    func deleteButtonDidTap(indexPath: IndexPath)
}

protocol ScheduleViewModelOutput {
    var model: [Schedule] { get }
    var _model: PassthroughSubject<[Schedule], Never> { get }
}

protocol ScheduleViewModelInterface {
    var input: ScheduleViewModelInput { get }
    var output: ScheduleViewModelOutput { get }
}


class ScheduleViewModel: ScheduleViewModelInterface, ScheduleViewModelInput, ScheduleViewModelOutput {
    var input: ScheduleViewModelInput { self }
    var output: ScheduleViewModelOutput { self }
    
    var model: [Schedule] = []
    var _model = PassthroughSubject<[Schedule], Never>()
    var email: String
    
    init(email: String) {
        self.email = email
    }
    
    func viewWillAppear() {
        FirebaseManager.shared.fetchAll { [weak self] schedules in
            if let self = self {
                let schedule = schedules.filter {
                    $0.email == self.email
                }
                
                self.model = schedule
                self._model.send(schedule)
            }
        }
    }
    
    func deleteButtonDidTap(indexPath: IndexPath) {
        FirebaseManager.shared.delete(schedule: model[indexPath.row]) {
            self.model.remove(at: indexPath.row)
            self._model.send(self.model)
        }
    }
}
