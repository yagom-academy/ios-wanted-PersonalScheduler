//
//  LoginSceneDIContainer.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

import UIKit

final class LoginSceneDIContainer {
    // MARK: - Login
    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController {
        let viewModel = makeLoginViewModel(actions: actions)
        return LoginViewController(with: viewModel)
    }
    
    func makeLoginViewModel(actions: LoginViewModelActions) -> LoginViewModel {
        return DefaultLoginViewModel(actions: actions)
    }
    
    // MARK: - Signin
    func makeSigninViewController(actions: SigninViewModelActions) -> SigninViewController {
        let viewModel = makeSigninViewModel(actions: actions)
        return SigninViewController(with: viewModel)
    }
    
    func makeSigninViewModel(actions: SigninViewModelActions) -> SigninViewModel {
        return DefaultSigninViewModel(actions: actions)
    }
    
    // MARK: - Login Flow Coordinator
    func makeLoginFlowCoordinator(navigationController: UINavigationController) -> LoginFlowCoordinator {
        return LoginFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
}

extension LoginSceneDIContainer: LoginFlowCoordinatorDependencies {}
