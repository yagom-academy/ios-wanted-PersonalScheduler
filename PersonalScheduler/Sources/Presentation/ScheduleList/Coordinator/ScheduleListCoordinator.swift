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
    
}

extension ScheduleListCoordinator: ScheduleListCoordinatorInterface {
    
}
