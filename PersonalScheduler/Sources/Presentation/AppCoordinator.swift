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
    
    public init(navigationConrtoller: UINavigationController) {
        self.navigationController = navigationConrtoller
    }
    
    public func start() {
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
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })

        switch childCoordinator.type {
        case .login:
            navigationController.viewControllers.removeAll()
            showMainFlow()
        default:
            break
        }
    }
}
