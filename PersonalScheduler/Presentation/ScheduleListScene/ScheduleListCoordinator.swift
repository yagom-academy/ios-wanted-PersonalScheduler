//
//  ScheduleListCoordinator.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/12.
//

import UIKit

final class ScheduleListCoordinator {
    var navigationController: UINavigationController
    private let scheduleListDIContinaer: ScheduleListDIContainer

    init(navigationController: UINavigationController, scheduleListDIContinaer: ScheduleListDIContainer) {
        self.navigationController = navigationController
        self.scheduleListDIContinaer = scheduleListDIContinaer
    }

    func start() {
        navigationController.popToRootViewController(animated: false)
        let scheduleListViewController = scheduleListDIContinaer.makeScheduleListViewController(coordinator: self)
        navigationController.pushViewController(scheduleListViewController, animated: true)
    }

    func showScheduleMaking() {
        let scheduleMakingViewController = scheduleListDIContinaer.makeScheduleMakingViewController()
        navigationController.present(scheduleMakingViewController, animated: true)
    }
}
