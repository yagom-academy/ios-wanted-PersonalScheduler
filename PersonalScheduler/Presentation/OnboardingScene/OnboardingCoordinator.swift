//
//  OnboardingCoordinator.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/12.
//

import UIKit

final class OnboardingCoordinator {
    var navigationController: UINavigationController
    private let onboardingDIContainer: OnboardingDIContainer

    init(navigationController: UINavigationController, onboardingDIContainer: OnboardingDIContainer) {
        self.navigationController = navigationController
        self.onboardingDIContainer = onboardingDIContainer
    }

    func start() {
        let onboardingViewController = onboardingDIContainer.makeOnboardingViewController(coordinator: self)
        navigationController.pushViewController(onboardingViewController, animated: true)
    }

    func loginFinished() {
        let scheduleListDIContainer = onboardingDIContainer.makeScheduleListDIContainer()
        let scheduleListCoordinator = scheduleListDIContainer.makeScheduleListCoordinator(navigationController: navigationController)
        scheduleListCoordinator.start()
    }
}
