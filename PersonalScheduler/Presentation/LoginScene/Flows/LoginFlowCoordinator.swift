//
//  LoginFlowCoordinator.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

import UIKit
import FirebaseAuth

protocol LoginFlowCoordinatorDependencies: AnyObject {
    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController
    func makeSigninViewController() -> SigninViewController
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
        let actions = LoginViewModelActions(
            successLogin: successLogin(_:),
            successKakaoLogin: successKakaoLogin,
            successFacebookLogin: successFacebookLogin,
            signinButtonTapped: signinButtonTapped
        )
        let loginVC = dependencies.makeLoginViewController(actions: actions)
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    private func successLogin(_ userName: String) {
        let newDependency = ScheduleSceneDIContainer()
        let flow = newDependency.makeMainFlowCoordinator(
            navigationController: self.navigationController,
            fireStoreCollectionId: userName
        )
        flow.start()
    }
    
    private func successKakaoLogin(_ email: String) {
        let newDependency = ScheduleSceneDIContainer()
        let flow = newDependency.makeMainFlowCoordinator(
            navigationController: self.navigationController,
            fireStoreCollectionId: email
        )
        flow.start()
    }
    
    private func successFacebookLogin(_ email: String) {
        let newDependency = ScheduleSceneDIContainer()
        let flow = newDependency.makeMainFlowCoordinator(
            navigationController: self.navigationController,
            fireStoreCollectionId: email
        )
        flow.start()
    }
    
    private func signinButtonTapped() {
        print("회원가입 버튼 탭 !")
        let signinVC = dependencies.makeSigninViewController()
        navigationController.pushViewController(signinVC, animated: true)
    }
}
