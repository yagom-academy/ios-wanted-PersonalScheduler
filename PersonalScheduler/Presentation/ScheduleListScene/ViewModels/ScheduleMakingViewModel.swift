//
//  ScheduleMakingViewModel.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/12.
//

import UIKit

final class ScheduleMakingViewModel {
    private let saveScheduleUseCase: SaveScheduleUseCase

    var dismiss: (() -> Void)?
    var showAlert: ((UIAlertController) -> Void)?

    init(saveScheduleUseCase: SaveScheduleUseCase) {
        self.saveScheduleUseCase = saveScheduleUseCase
    }

    func saveScheduleButtonTapped(title: String?, description: String?, startDate: Date, endDate: Date) {
        let schedule = Schedule(id: UUID(), title: title ?? "", description: description ?? "",
                                startDate: startDate, endDate: endDate)
        saveScheduleUseCase.execute(schedule: schedule) { [weak self] result in
            switch result {
            case .success:
                self?.dismiss?()
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription,
                                              preferredStyle: .alert)
                self?.showAlert?(alert)
            }
        }
    }
}
