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
    }
    
    @objc func loginButtonTapped() {
        viewModel.loginButtonTapped()
    }
}
