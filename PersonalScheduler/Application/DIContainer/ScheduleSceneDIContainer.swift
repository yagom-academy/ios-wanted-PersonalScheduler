//
//  ScheduleSceneDIContainer.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

import UIKit

final class ScheduleSceneDIContainer {
    // MARK: - Schedule List
    func makeScheduleListViewController(actions: ScheduleListViewModelActions) -> ScheduleListViewController {
        let viewModel = makeScheduleListViewModel(actions: actions)
        return ScheduleListViewController(with: viewModel)
    }
    
    func makeScheduleListViewModel(actions: ScheduleListViewModelActions) -> ScheduleListViewModel {
        return DefaultScheduleListViewModel(actions: actions)
    }
    
    // MARK: - Schedule Detail
    func makeScheduleDetailViewController(schedule: Schedule) -> ScheduleDetailViewController {
        let viewModel = makeScheduleDetailViewModel(with: schedule)
        return ScheduleDetailViewController(with: viewModel)
    }
    
    func makeScheduleDetailViewModel(with schedule: Schedule) -> ScheduleDetailViewModel {
        return DefaultScheduleDetailViewModel(currentSchedule: schedule)
    }
    
    // MARK: - Main Flow Coordinator
    func makeMainFlowCoordinator(
        navigationController: UINavigationController
    ) -> MainFlowCoordinator {
        
        return MainFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
}

extension ScheduleSceneDIContainer: MainFlowCoordinatorDependencies {}
