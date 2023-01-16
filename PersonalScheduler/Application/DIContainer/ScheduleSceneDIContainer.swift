//
//  ScheduleSceneDIContainer.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

import UIKit

final class ScheduleSceneDIContainer {
    // MARK: - Schedule List
    func makeScheduleListViewController(fireStoreCollectionId: String,
                                        actions: ScheduleListViewModelActions) -> ScheduleListViewController {
        let viewModel = makeScheduleListViewModel(fireStoreCollectionId: fireStoreCollectionId, actions: actions)
        return ScheduleListViewController(with: viewModel)
    }
    
    func makeScheduleListViewModel(fireStoreCollectionId: String,
                                   actions: ScheduleListViewModelActions) -> ScheduleListViewModel {
        return DefaultScheduleListViewModel(fireStoreCollectionId: fireStoreCollectionId, actions: actions)
    }
    
    // MARK: - Schedule Detail
    func makeScheduleDetailViewController(schedule: Schedule?,
                                          fireStoreCollectionId: String) -> ScheduleDetailViewController {
        let viewModel = makeScheduleDetailViewModel(
            with: schedule,
            fireStoreCollectionId: fireStoreCollectionId
        )
        return ScheduleDetailViewController(with: viewModel)
    }
    
    func makeScheduleDetailViewModel(with schedule: Schedule?,
                                     fireStoreCollectionId: String) -> ScheduleDetailViewModel {
        return DefaultScheduleDetailViewModel(
            currentSchedule: schedule,
            fireStoreCollectionId: fireStoreCollectionId
        )
    }
    
    // MARK: - Main Flow Coordinator
    func makeMainFlowCoordinator(navigationController: UINavigationController,
                                 fireStoreCollectionId: String) -> MainFlowCoordinator {
        
        return MainFlowCoordinator(
            navigationController: navigationController,
            dependencies: self,
            fireStoreCollectionId: fireStoreCollectionId
        )
    }
}

extension ScheduleSceneDIContainer: MainFlowCoordinatorDependencies {}
