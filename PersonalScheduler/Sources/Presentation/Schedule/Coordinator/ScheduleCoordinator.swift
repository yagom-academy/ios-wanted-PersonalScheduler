//
//  ScheduleCoordinator.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import UIKit

final class ScheduleCoordinator: Coordinator {
    
    let type: CoordinatorType
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, type: CoordinatorType) {
        self.navigationController = navigationController
        self.type = type
    }
    
    func start() {
        let viewController = makeScheduleViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

private extension ScheduleCoordinator {
    
    func makeScheduleViewController() -> UIViewController {
        let viewController = ScheduleViewController(
            viewModel: ScheduleViewModel(),
            coordinator: self
        )
        return viewController
    }
    
}

extension ScheduleCoordinator: ScheduleCoordinatorInterface {
    
}
