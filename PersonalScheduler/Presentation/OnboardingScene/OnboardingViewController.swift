//
//  ViewController.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit

final class OnboardingViewController: UIViewController {

    private let viewModel = OnboardingViewModel()

    private lazy var appleLoginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Apple로 로그인하기", for: .normal)
        button.titleLabel?.textColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction { [weak self] action in
            self?.viewModel.appleLoginButtonTapped()
        }, for: .touchUpInside)
        return button
    }()

    private lazy var kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Kakao로 로그인하기", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .systemYellow
        button.addAction(UIAction { [weak self] action in
            self?.viewModel.kakaoLoginButtonTapped()
        }, for: .touchUpInside)
        return button
    }()

    private lazy var naverLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Naver로 로그인하기", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .systemGreen
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
            kakaoLoginButton.heightAnchor.constraint(equalToConstant: 50),

            appleLoginButton.bottomAnchor.constraint(equalTo: kakaoLoginButton.topAnchor, constant: -10),
            appleLoginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            appleLoginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            appleLoginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
