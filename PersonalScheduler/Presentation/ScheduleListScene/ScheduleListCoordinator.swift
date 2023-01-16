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

    private var scheduleListViewController: ScheduleListViewController!
    private var scheduleMakingViewController: ScheduleMakingViewController!

    init(navigationController: UINavigationController, scheduleListDIContinaer: ScheduleListDIContainer) {
        self.navigationController = navigationController
        self.scheduleListDIContinaer = scheduleListDIContinaer
    }

    func start() {
        navigationController.popToRootViewController(animated: false)
        scheduleListViewController = scheduleListDIContinaer.makeScheduleListViewController(coordinator: self)
        navigationController.pushViewController(scheduleListViewController, animated: true)
    }

    func showScheduleMaking() {
        scheduleMakingViewController = scheduleListDIContinaer.makeScheduleMakingViewController(coordinator: self)
        navigationController.present(scheduleMakingViewController, animated: true)
    }

    func dismissScheduleMaking() {
        scheduleMakingViewController.dismiss(animated: true) { [weak self] in
            self?.scheduleListViewController.viewWillAppear(true)
        }
    }
}
