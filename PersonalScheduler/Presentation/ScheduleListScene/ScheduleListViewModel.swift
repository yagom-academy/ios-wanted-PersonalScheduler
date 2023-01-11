//
//  ScheduleListViewModel.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/11.
//

import UIKit

final class ScheduleListViewModel {

    // MARK: - Outputs
    private var schedules = [Schedule]()

    func schedules(section: ScheduleListViewController.ScheduleSection) -> [Schedule] {
        switch section {
        case .current:
            return schedules.filter { $0.title == "첫번째 제목" } // TODO: Need to make filter logic
        case .upcoming:
            return schedules.filter { $0.title == "두번째 제목" }
        case .done:
            return schedules.filter { $0.title != "첫번째 제목" && $0.title != "두번째 제목" }
        }
    }
    var days = (1...31).map { $0 }
    var applyDataSource: (() -> Void)?
    var showAlert: ((UIAlertController) -> Void)?

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
                let alert = UIAlertController(title: "Error", message: error.localizedDescription,
                                              preferredStyle: .alert)
                self.showAlert?(alert)
            }
        }
    }
}

// MARK: - Inputs
extension ScheduleListViewModel {
    func viewDidLoad() {
        applyDataSource?()
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
