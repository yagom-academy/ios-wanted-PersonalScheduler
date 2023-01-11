//
//  ScheduleListViewModel.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/11.
//

import Foundation

final class ScheduleListViewModel {

    // MARK: - Outputs
    var schedules = [Schedule]()
    var days = (1...31).map { $0 }
    var applyDataSource: (() -> Void)?

    // MARK: - UseCases
    private let fetchScheduleUseCase: FetchScheduleUseCase

    init(fetchScheduleUseCase: FetchScheduleUseCase) {
        self.fetchScheduleUseCase = fetchScheduleUseCase
    }

    private func fetchSchedules(date: Date) {
        fetchScheduleUseCase.execute(for: date) { result in
            switch result {
            case .success(let schedules):
                self.schedules = schedules
                self.applyDataSource?()
            case .failure(let error):
                print("show alert")
            }
        }
    }
}

// MARK: - Inputs
extension ScheduleListViewModel {
    func viewDidLoad() {
        fetchSchedules(date: Date())
    }

    func viewWillAppear() {

    }

    func dateCellSelected(date: Date) {

    }

    func deleteActionDone(indexPath: IndexPath) {

    }

    func todayButtonTapped() {

    }
}
