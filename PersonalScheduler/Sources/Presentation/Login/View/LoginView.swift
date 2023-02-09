//
//  LoginView.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import UIKit

final class LoginView: UIView {
    let kakaoLoginButton = SocialLoginButton(loginType: .kakao)
    let facebookLoginButton = SocialLoginButton(loginType: .facebook)
    let appleLoginButton = SocialLoginButton(loginType: .apple)
    
    init() {
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure UI
private extension LoginView {
    func configureUI() {
        backgroundColor = .systemBackground
        addChildComponents()
        setUpLayout()
    }
    
    func addChildComponents() {
        [kakaoLoginButton, facebookLoginButton, appleLoginButton].forEach(addSubview)
    }
    
    func setUpLayout() {
        NSLayoutConstraint.activate([
            appleLoginButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            appleLoginButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            appleLoginButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            facebookLoginButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            facebookLoginButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            facebookLoginButton.bottomAnchor.constraint(equalTo: appleLoginButton.topAnchor, constant: -16),
            
            kakaoLoginButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            kakaoLoginButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            kakaoLoginButton.bottomAnchor.constraint(equalTo: facebookLoginButton.topAnchor, constant: -16),
        ])
        
        [kakaoLoginButton, facebookLoginButton, appleLoginButton].forEach {
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }
}
