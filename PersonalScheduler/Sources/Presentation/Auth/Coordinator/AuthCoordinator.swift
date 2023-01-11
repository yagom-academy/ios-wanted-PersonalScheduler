//
//  AuthCoordinator.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import UIKit

final class AuthCoordinator: Coordinator {
    
    var type: CoordinatorType { .login }
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let viewController = makeAuthViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

private extension AuthCoordinator {
    
    func makeAuthViewController() -> UIViewController {
        let viewController = AuthViewController(
            viewModel: DefaultAuthViewModel(),
            coordinator: self
        )
        return viewController
    }
    
}

extension AuthCoordinator: AuthCoordinatorInterface {
    
    func finished() {
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
}
