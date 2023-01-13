//
//  MainFlowCoordinator.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

import UIKit

protocol MainFlowCoordinatorDependencies {
    func makeScheduleListViewController(fireStoreCollectionId: String,
                                        actions: ScheduleListViewModelActions) -> ScheduleListViewController
    func makeScheduleDetailViewController(schedule: Schedule?,
                                          fireStoreCollectionId: String) -> ScheduleDetailViewController
}

final class MainFlowCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    
    private var navigationController: UINavigationController!
    private let dependencies: MainFlowCoordinatorDependencies
    private let fireStoreCollectionId: String
    
    init(navigationController: UINavigationController,
         dependencies: ScheduleSceneDIContainer,
         fireStoreCollectionId: String) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.fireStoreCollectionId = fireStoreCollectionId
    }
    
    func start() {
        let actions = ScheduleListViewModelActions(
            showScheduleDetails: showScheduleDetails,
            createNewSchedule: createNewSchedule
        )
        let scheduleListVC = dependencies.makeScheduleListViewController(
            fireStoreCollectionId: fireStoreCollectionId,
            actions: actions
        )
        self.navigationController.pushViewController(scheduleListVC, animated: true)
    }
    
    private func showScheduleDetails(schedule: Schedule) {
        let scheduleDetailVC = dependencies.makeScheduleDetailViewController(
            schedule: schedule,
            fireStoreCollectionId: fireStoreCollectionId
        )
        navigationController.pushViewController(scheduleDetailVC, animated: true)
    }
    
    private func createNewSchedule() {
        let scheduleDetailVC = dependencies.makeScheduleDetailViewController(
            schedule: nil,
            fireStoreCollectionId: fireStoreCollectionId
        )
        navigationController.pushViewController(scheduleDetailVC, animated: true)
    }
}
