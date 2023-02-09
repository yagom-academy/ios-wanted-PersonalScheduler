//
//  LoginViewController.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit
import AuthenticationServices
import FacebookLogin
import Combine

final class LoginViewController: UIViewController {
    private let viewModel = LoginViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    private let contentView = LoginView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        bindAction()
    }
}

// MARK: - Binding Method
private extension LoginViewController {
    func bind() {
        
        viewModel.isSuccess
            .receive(on: DispatchQueue.main)
            .sink {
                if $0 {
                    self.presentMainViewController()
                } else {
                    // TODO: - Error Handling
                }
            }
            .store(in: &cancellable)
    }
    
    func bindAction() {
        
        contentView.kakaoLoginButton.tapPublisher
            .sink { _ in
                let repository = KakaoLoginRepository()
                self.viewModel.login(with: repository)
            }
            .store(in: &cancellable)
        
        contentView.facebookLoginButton.tapPublisher
            .sink { _ in
                let repository = FacebookRepository()
                self.viewModel.login(with: repository)
            }
            .store(in: &cancellable)

        contentView.appleLoginButton.tapPublisher
            .sink { _ in self.presentAppleLoginSheet() }
            .store(in: &cancellable)
    }
}
extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        switch authorization.credential {
        case let appleIdCredential as ASAuthorizationAppleIDCredential:
            let repository = AppleLoginRepository(credential: appleIdCredential)
            viewModel.login(with: repository)
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // TODO: - Error Alert 띄우기
    }
}

// MARK: - Authorization Controller Context Providing
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window ?? UIWindow()
    }
}

// MARK: - Present Method
private extension LoginViewController {
    func presentMainViewController() {
        let controller = UIViewController()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.view.backgroundColor = .red
        present(controller, animated: true)
    }
    
    func presentAppleLoginSheet() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}
