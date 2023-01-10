//
//  ViewController.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit
import AuthenticationServices

final class OnboardingViewController: UIViewController {

    private let viewModel = OnboardingViewModel()

    private lazy var appleLoginButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(type: .signUp, style: .black)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction { [weak self] action in
            self?.viewModel.appleLoginButtonTapped()
        }, for: .touchUpInside)
        return button
    }()

    private lazy var kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.addAction(UIAction { [weak self] action in
            self?.viewModel.kakaoLoginButtonTapped()
        }, for: .touchUpInside)
        return button
    }()

    private lazy var naverLoginButton: UIButton = {
        let button = UIButton()
        button.addAction(UIAction { [weak self] action in
            self?.viewModel.naverLoginButtonTapped()
        }, for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    private func layout() {
        [appleLoginButton, kakaoLoginButton, naverLoginButton].forEach {
            view.addSubview($0)
        }
        NSLayoutConstraint.activate([
            naverLoginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            naverLoginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            naverLoginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            naverLoginButton.heightAnchor.constraint(equalToConstant: 50),

            kakaoLoginButton.bottomAnchor.constraint(equalTo: naverLoginButton.topAnchor, constant: -10),
            kakaoLoginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            kakaoLoginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),

            appleLoginButton.bottomAnchor.constraint(equalTo: kakaoLoginButton.topAnchor, constant: -10),
            appleLoginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            appleLoginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
}
