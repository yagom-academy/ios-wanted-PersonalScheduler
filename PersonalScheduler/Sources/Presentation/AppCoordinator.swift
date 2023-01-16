//
//  AppCoordinator.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import UIKit

final class AppCoordinator: Coordinator {
    var type: CoordinatorType { .root }
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let coordinator = makeAuthCoordinator()
        coordinator.start()
    }
}

private extension AppCoordinator {
    func makeAuthCoordinator() -> Coordinator {
        let coordinator = AuthCoordinator(navigationController: navigationController)
        coordinator.finishDelegate = self
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        return coordinator
    }
    
    func showMainFlow() {
        let coordinator = ScheduleListCoordinator(navigationController: navigationController)
        coordinator.finishDelegate = self
        coordinator.parentCoordinator = self
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childDidFinish(childCoordinator, parent: self)

        switch childCoordinator.type {
        case .login:
            navigationController.viewControllers.removeAll()
            navigationController.setNavigationBarHidden(false, animated: false)
            showMainFlow()
        case .list:
            navigationController.viewControllers.removeAll()
            navigationController.setNavigationBarHidden(true, animated: false)
            start()
        default:
            break
        }
    }
}
