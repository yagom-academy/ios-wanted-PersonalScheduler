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
        if startDate >= endDate {
            let alert = UIAlertController(title: "종료시간은 시작시간 이후여야 합니다.", message: nil,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            showAlert?(alert)
            return
        }
        saveScheduleUseCase.execute(schedule: schedule) { [weak self] result in
            switch result {
            case .success:
                self?.addNotification(schedule: schedule)
                self?.dismiss?()
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription,
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel))
                self?.showAlert?(alert)
            }
        }
    }

    private func addNotification(schedule: Schedule) {
        let push =  UNMutableNotificationContent()
        push.title = schedule.title
        push.body = schedule.description
        push.badge = 1

        let interval = schedule.startDate.timeIntervalSince(Date())

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        let request = UNNotificationRequest(identifier: schedule.id.uuidString, content: push, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
