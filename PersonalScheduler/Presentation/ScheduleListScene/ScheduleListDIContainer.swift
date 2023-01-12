//
//  ScheduleListDIContainer.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/11.
//

import UIKit

final class ScheduleListDIContainer {

    // MARK: - Coordinators

    func makeScheduleListCoordinator(navigationController: UINavigationController) -> ScheduleListCoordinator {
        return ScheduleListCoordinator(navigationController: navigationController, scheduleListDIContinaer: self)
    }

    // MARK: - Repositories

    func makeScheduleListRepository() -> ScheduleListRepository {
        return ScheduleListRepository()
    }

    // MARK: - UseCases

    func makeFetchScheduleUseCase() -> FetchScheduleUseCase {
        return FetchScheduleUseCase(repository: makeScheduleListRepository())
    }

    func makeDeleteScheduleUseCase() -> DeleteScheduleUseCase {
        return DeleteScheduleUseCase(repository: makeScheduleListRepository())
    }

    // MARK: - ViewModels

    func makeScheduleListViewModel() -> ScheduleListViewModel {
        return ScheduleListViewModel(fetchScheduleUseCase: makeFetchScheduleUseCase(),
                                     deleteScheduleUseCase: makeDeleteScheduleUseCase())
    }

    func makeScheduleMakingViewModel() -> ScheduleMakingViewModel {
        return ScheduleMakingViewModel()
    }

    // MARK: - ViewControllers

    func makeScheduleMakingViewController() -> ScheduleMakingViewController {
        return ScheduleMakingViewController(viewModel: makeScheduleMakingViewModel())
    }

    func makeScheduleListViewController(coordinator: ScheduleListCoordinator) -> ScheduleListViewController {
        return ScheduleListViewController(viewModel: makeScheduleListViewModel(), coordinator: coordinator)
    }
}
