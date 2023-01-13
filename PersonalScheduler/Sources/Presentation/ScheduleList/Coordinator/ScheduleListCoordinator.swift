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
    
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = makeScheduleListViewController()
        navigationController.pushViewController(viewController, animated: true)
        NotificationCenter.default.addObserver(self, selector: #selector(showScheduleList(_:)), name: .showScheduleList, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .showScheduleList, object: nil)
    }
    
}

private extension ScheduleListCoordinator {
    
    func makeScheduleListViewController() -> UIViewController {
        let viewController = ScheduleListViewController(
            viewModel: DefaultScheduleListViewModel(),
            coordinator: self
        )
        return viewController
    }
    
    
    func makeScheduleCoordinator(type: CoordinatorType, schedule: Schedule) -> Coordinator? {
        let coordinator: ScheduleCoordinator
        switch type {
        case .create:
            coordinator = ScheduleCoordinator(navigationController: .init(), type: type, schedule: schedule)
        case .edit:
            coordinator = ScheduleCoordinator(navigationController: navigationController, type: type, schedule: schedule)
        default: return nil
        }
        coordinator.finishDelegate = self
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        return coordinator
    }
    
    @objc func showScheduleList(_ notification: Notification) {
        guard let scheduleID = notification.object as? String, childCoordinators.isEmpty else {
            return
        }
        NotificationCenter.default.post(name: .scrollToSchedule, object: scheduleID)
    }
    
}

extension ScheduleListCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childDidFinish(childCoordinator, parent: self)
        
        switch childCoordinator.type {
        case .create:
            navigationController.visibleViewController?.dismiss(animated: true)
            
        case .edit:
            navigationController.popViewController(animated: true)
            
        default: break
        }
    }
}

extension ScheduleListCoordinator: ScheduleListCoordinatorInterface {
    
    func showCreateSchedule() {
        let coordinator = makeScheduleCoordinator(type: .create, schedule: Schedule())
        coordinator?.start()
        let viewController = coordinator?.navigationController ?? UIViewController()
        viewController.modalPresentationStyle = .fullScreen
        navigationController.visibleViewController?.present(viewController, animated: true)
    }
    
    func showEditSchedule(_ schedule: Schedule) {
        let coordinator = makeScheduleCoordinator(type: .edit, schedule: schedule)
        coordinator?.start()
    }
    
    func finished() {
        navigationController.popViewController(animated: false)
        navigationController.viewControllers.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}


