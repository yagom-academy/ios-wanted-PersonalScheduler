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
    
    private let schedule: Schedule
    
    init(navigationController: UINavigationController, type: CoordinatorType, schedule: Schedule) {
        self.navigationController = navigationController
        self.type = type
        self.schedule = schedule
    }
    
    func start() {
        let viewController = makeScheduleViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

private extension ScheduleCoordinator {
    
    func makeScheduleViewController() -> UIViewController {
        let viewController = ScheduleViewController(
            viewModel: DefaultScheduleViewModel(
                schedule: schedule,
                type: type == .create ? .create : .edit
            ),
            coordinator: self,
            type: type == .create ? .create : .edit
        )
        return viewController
    }
    
}

extension ScheduleCoordinator: ScheduleCoordinatorInterface {
    
    func dismiss() {
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
}
