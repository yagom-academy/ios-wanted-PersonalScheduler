//
//  DIContainer.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/11.
//

import Foundation

final class DIContainer {
    func makeOnboardingViewController() -> OnboardingViewController {
        return OnboardingViewController()
    }

    func makeScheduleListViewController() -> ScheduleListViewController {
        return ScheduleListViewController(viewModel: makeScheduleListViewModel())
    }

    func makeScheduleListViewModel() -> ScheduleListViewModel {
        return ScheduleListViewModel(fetchScheduleUseCase: makeFetchScheduleUseCase(),
                                     deleteScheduleUseCase: makeDeleteScheduleUseCase())
    }

    func makeOAuthLoginUseCase() -> OAuthLoginUseCase {
        return OAuthLoginUseCase()
    }

    func makeFetchScheduleUseCase() -> FetchScheduleUseCase {
        return FetchScheduleUseCase(repository: ScheduleListRepository())
    }

    func makeDeleteScheduleUseCase() -> DeleteScheduleUseCase {
        return DeleteScheduleUseCase(repository: ScheduleListRepository())
    }
}
