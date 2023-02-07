//
//  LoginViewController.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit
import AuthenticationServices
import FacebookLogin

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setButtonAction()
        
        if let token = AccessToken.current {
            // TODO: - Facebook Login Token 관리하기
            print(token)
        }
    }
}

private extension LoginViewController {
    func setButtonAction() {
        kakaoLoginButton.addTarget(self, action: #selector(didTapKakaoLogin), for: .touchUpInside)
        facebookLoginButton.addTarget(self, action: #selector(didTapFaceBookLogin), for: .touchUpInside)
        appleLoginButton.addTarget(self, action: #selector(tapAppleLogin), for: .touchUpInside)
    }
    
    @objc func didTapKakaoLogin() {
        viewModel.loginKakao()
    }
    
    @objc func didTapFaceBookLogin() {
        viewModel.faceBookLogin(from: self) { result in
            // TODO: - Handling Token
        }
    }
    
    @objc func tapAppleLogin() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
    }
}

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

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let user = credential.user
            
            print("user \(user)")
            
            if let email = credential.email {
                print("email \(email)")
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Error \(error)")
    }
}
