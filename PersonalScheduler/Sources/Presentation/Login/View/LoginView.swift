//
//  LoginView.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import UIKit

final class LoginView: UIView {
    let appleLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("애플로 로그인하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        return button
    }()
    
    let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("카카오로 로그인하기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 10
        return button
    }()
    
    let facebookLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("facebook으로 로그인하기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
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
            kakaoLoginButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            kakaoLoginButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            kakaoLoginButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -200),
            
            facebookLoginButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            facebookLoginButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            facebookLoginButton.topAnchor.constraint(equalTo: kakaoLoginButton.bottomAnchor, constant: 30),
            
            appleLoginButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            appleLoginButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            appleLoginButton.topAnchor.constraint(equalTo: facebookLoginButton.bottomAnchor, constant: 30)
        ])
    }
}
