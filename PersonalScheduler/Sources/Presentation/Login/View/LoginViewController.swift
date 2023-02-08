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
    private let appleLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("애플로 로그인하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("카카오로 로그인하기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let facebookLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("facebook으로 로그인하기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let viewModel = LoginViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bindAction()
        
        if let token = AccessToken.current {
            // TODO: - Facebook Login Token 관리하기
            print(token)
        }
    }
}

private extension LoginViewController {
    func bindAction() {
        kakaoLoginButton
            .tapPublisher
            .sink { _ in
                self.viewModel.loginKakao()
            }
            .store(in: &cancellable)
        
        facebookLoginButton
            .tapPublisher
            .sink { _ in
                self.viewModel.faceBookLogin(from: self) { result in
                    print(result)
                }
            }
            .store(in: &cancellable)
        
        appleLoginButton
            .tapPublisher
            .sink { _ in
                let request = ASAuthorizationAppleIDProvider().createRequest()
                request.requestedScopes = [.fullName, .email]
                let controller = ASAuthorizationController(authorizationRequests: [request])
                controller.delegate = self.viewModel
                controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
                controller.performRequests()
            }
            .store(in: &cancellable)
    }
}

// MARK: - Configure UI
private extension LoginViewController {
    func configureUI() {
        view.backgroundColor = .systemBackground
        setAdditionalInset()
        addChildComponents()
        setUpLayout()
    }
    
    func setAdditionalInset() {
        additionalSafeAreaInsets.left += 16
        additionalSafeAreaInsets.right += 16
    }
    
    func addChildComponents() {
        [kakaoLoginButton, facebookLoginButton, appleLoginButton].forEach(view.addSubview)
    }
    
    func setUpLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            kakaoLoginButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            kakaoLoginButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            kakaoLoginButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -200),
            
            facebookLoginButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            facebookLoginButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            facebookLoginButton.topAnchor.constraint(equalTo: kakaoLoginButton.bottomAnchor, constant: 30),
            
            appleLoginButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            appleLoginButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            appleLoginButton.topAnchor.constraint(equalTo: facebookLoginButton.bottomAnchor, constant: 30)
        ])
    }
}

private extension UIButton {
    var tapPublisher: AnyPublisher<Void, Never> {
        controlPublisher(for: .touchUpInside)
            .map { _ in }
            .eraseToAnyPublisher()
    }
}
