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
    private let appleLoginButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        return button
    }()
    
    private let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("카카오로 로그인하기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let facebookLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("facebook으로 로그인하기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(appleLoginButton)
        appleLoginButton.center = self.view.center
        
        appleLoginButton.addTarget(self, action: #selector(tapAppleLogin), for: .touchUpInside)
        
        configureUI()
        setButtonAction()
        
        if let token = AccessToken.current {
            print(token)
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
    func setButtonAction() {
        kakaoLoginButton.addTarget(self, action: #selector(didTapKakaoLogin), for: .touchUpInside)
        facebookLoginButton.addTarget(self, action: #selector(didTapFaceBookLogin), for: .touchUpInside)
    }
    
    @objc func didTapKakaoLogin() {
        viewModel.loginKakao()
    }
    
    @objc func didTapFaceBookLogin() {
        viewModel.faceBookLogin(from: self) { result in
            // TODO: - Handling Token
        }
    }
}

private extension LoginViewController {
    func configureUI() {
        addChildComponents()
        setUpLayout()
    }
    
    func addChildComponents() {
        [kakaoLoginButton, facebookLoginButton].forEach(view.addSubview)
    }
    
    func setUpLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            kakaoLoginButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            kakaoLoginButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            kakaoLoginButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -200),
            
            facebookLoginButton.leadingAnchor.constraint(equalTo: kakaoLoginButton.leadingAnchor),
            facebookLoginButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            facebookLoginButton.topAnchor.constraint(equalTo: kakaoLoginButton.bottomAnchor, constant: 30)
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
