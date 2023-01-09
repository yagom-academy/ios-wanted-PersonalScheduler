//
//  LoginViewController.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

import UIKit

final class LoginViewController: UIViewController {
    private let loginView = LoginView()
    private let viewModel: LoginViewModel
    
    init(with viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        setupButton()
    }
    
    private func setupInitialView() {
        view = loginView
    }
    
    private func setupButton() {
        loginView.loginButton.addTarget(
            self,
            action: #selector(loginButtonTapped),
            for: .touchUpInside
        )
        
        loginView.signInButton.addTarget(
            self,
            action: #selector(signInButtonTapped),
            for: .touchUpInside
        )
        
        loginView.kakaoLogoImageButton.addTarget(
            self,
            action: #selector(kakaoButtonTapped),
            for: .touchUpInside
        )
        
        loginView.facebookLogoImageButton.addTarget(
            self,
            action: #selector(facebookButtonTapped),
            for: .touchUpInside
        )
        
        loginView.appleLogoImageButton.addTarget(
            self,
            action: #selector(appleButtonTapped),
            for: .touchUpInside
        )
    }
    
    @objc private func loginButtonTapped() {
        viewModel.loginButtonTapped()
    }
    
    @objc private func signInButtonTapped() {
        viewModel.signinButtonTapped()
    }
    
    @objc private func kakaoButtonTapped() {
        viewModel.kakaoLogoButtonTapped()
    }
    
    @objc private func facebookButtonTapped() {
        viewModel.facebookLogoButtonTapped()
    }
    
    @objc private func appleButtonTapped() {
        viewModel.appleLogoButtonTapped()
    }
}
