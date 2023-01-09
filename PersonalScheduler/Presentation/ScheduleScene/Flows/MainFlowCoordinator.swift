//
//  MainFlowCoordinator.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

import UIKit

protocol MainFlowCoordinatorDependencies {
    func makeScheduleListViewController(actions: ScheduleListViewModelActions) -> ScheduleListViewController
    func makeScheduleDetailViewController(schedule: Schedule) -> ScheduleDetailViewController
}

final class MainFlowCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    
    private var navigationController: UINavigationController!
    private let dependencies: MainFlowCoordinatorDependencies
    
    init(navigationController: UINavigationController,
         dependencies: ScheduleSceneDIContainer) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = ScheduleListViewModelActions(
            showScheduleDetails: showScheduleDetails
        )
        let scheduleListVC = dependencies.makeScheduleListViewController(
            actions: actions
        )
        self.navigationController.pushViewController(scheduleListVC, animated: true)
    }
    
    private func showScheduleDetails(schedule: Schedule) {
        let scheduleDetailVC = dependencies.makeScheduleDetailViewController(schedule: schedule)
        //
        navigationController.pushViewController(scheduleDetailVC, animated: true)
    }
}
