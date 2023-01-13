//
//  ViewController.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit
import AuthenticationServices

// MARK: - Life Cycle

final class LoginViewController: UIViewController {

    private let viewModel: LoginViewModel!
    
    private let signInButtonStackView: UIStackView = {
        let st = UIStackView()
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    private let appleSignInButton: ASAuthorizationAppleIDButton = {
        let btn = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        return btn
    }()
    
    init(viewModel: LoginViewModel = LoginViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = LoginViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
        makeConstraints()
    }
}

// MARK: - Actions

extension LoginViewController {
    
    @objc
    private func signInButtonTapped(_ sender: ASAuthorizationAppleIDButton) {
        viewModel.appleLoginIn()
    }
}

// MARK: - Attributes

extension LoginViewController {
    
    private func setupViews() {
        setupSignInButtonStackView()
        setupAppleSignInButton()
    }
    
    private func setupSignInButtonStackView() {
        view.addSubview(signInButtonStackView)
    }
    
    private func setupAppleSignInButton() {
        signInButtonStackView.addArrangedSubview(appleSignInButton)
        appleSignInButton.addTarget(self, action: #selector(signInButtonTapped(_:)), for: .touchUpInside)
    }
}

// MARK: - Bind

extension LoginViewController {
 
    private func bind() {
        
    }
}

// MARK: - Constraints

extension LoginViewController {
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            signInButtonStackView
                .centerXAnchor
                .constraint(equalTo: view.centerXAnchor),
            signInButtonStackView
                .centerYAnchor
                .constraint(equalTo: view.centerYAnchor)
        ])
    }
}
