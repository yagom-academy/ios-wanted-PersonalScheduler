//
//  LoginFlowCoordinator.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

import UIKit

protocol LoginFlowCoordinatorDependencies: AnyObject {
    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController
}

final class LoginFlowCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    private var dependencies: LoginFlowCoordinatorDependencies
    private var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController,
         dependencies: LoginFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = LoginViewModelActions(loginButtonTapped: loginButtonTapped)
        let loginVC = dependencies.makeLoginViewController(actions: actions)
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    private func loginButtonTapped() {
        // 유효성 검사 후.
        
        // 맞으면
        // MainFlowCoordinator 로 넘어가기
        let newDependency = ScheduleSceneDIContainer()
        let flow = newDependency.makeMainFlowCoordinator(navigationController: navigationController)
        flow.start()
        
        // 틀리면
        // 오류처리 해주기.
    }
}
