//
//  ScheduleListCoordinator.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import UIKit

final class ScheduleListCoordinator: Coordinator {
    
    var type: CoordinatorType { .list }
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = makeScheduleListViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

private extension ScheduleListCoordinator {
    
    func makeScheduleListViewController() -> UIViewController {
        let viewController = ScheduleListViewController(
            viewModel: ScheduleListViewModel(),
            coordinator: self
        )
        return viewController
    }
    
    
    func makeScheduleCoordinator(type: CoordinatorType) -> Coordinator {
        let coordinator = ScheduleCoordinator(navigationController: navigationController, type: type)
        coordinator.finishDelegate = self
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        return coordinator
    }
    
}

extension ScheduleListCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childDidFinish(childCoordinator, parent: self)
        
        switch childCoordinator.type {
        case .create: navigationController.visibleViewController?.dismiss(animated: true)
        case .edit: navigationController.popViewController(animated: true)
        default: break
        }
    }
}

extension ScheduleListCoordinator: ScheduleListCoordinatorInterface {
    
    func showCreateSchedule() {
        
    }
    
    func showEditSchedule() {
        
    }
}


