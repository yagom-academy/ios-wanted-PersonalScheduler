//
//  OnboardingDIContainer.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/12.
//

final class OnboardingDIContainer {
    func makeOnboardingViewController(coordinator: OnboardingCoordinator) -> OnboardingViewController {
        return OnboardingViewController(coordinator: coordinator)
    }

    func makeOAuthLoginUseCase() -> OAuthLoginUseCase {
        return OAuthLoginUseCase(repository: makeOAuthRepository())
    }

    func makeOAuthRepository() -> OAuthRepository {
        return OAuthRepository()
    }

    func makeScheduleListDIContainer() -> ScheduleListDIContainer {
        return ScheduleListDIContainer()
    }
}
