//
//  LoginViewController.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 06/01/23.
//

import UIKit

final class LoginViewController: UIViewController {

    private let viewModel: LoginViewModel = LoginViewModel()
    
    private lazy var loginLabel = UILabel(text: viewModel.title, font: .largeTitle, fontBold: true, textColor: .navy)
    private lazy var introduceLabel = UILabel(text: viewModel.introduce, textColor: .secondary)

    private let calendarImageView: UIImageView = {
        let calendarImage = UIImage(named: "Calendar")
        let imageView = UIImageView(image: calendarImage)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private lazy var kakaoLoginButton: LoginButton = {
        let loginButton = LoginButton()
        loginButton.configure(with: viewModel.kakaoLoginButtonViewModel)
        loginButton.addTarget(self, action: #selector(loginWidthKakao), for: .touchUpInside)

        return loginButton
    }()

    private lazy var facebookLoginButton: LoginButton = {
        let loginButton = LoginButton()
        loginButton.configure(with: viewModel.facebookLoginButtonViewModel)
        loginButton.addTarget(self, action: #selector(loginWidthFaceBook), for: .touchUpInside)

        return loginButton
    }()

    private let loginStackView = UIStackView(axis: .vertical,
                                             spacing: 15,
                                             radius: 30,
                                             backgroundColor: .tertiary,
                                             margin: 20)

    override func viewDidLoad() {
        super.viewDidLoad()
        drawView()
    }

    @objc private func loginWidthKakao() {
        viewModel.loginWithKakao()
    }

    @objc private func loginWidthFaceBook() {
        viewModel.loginWithFacebook(target: self)
    }
}

//MARK: - ViewHierarchy and Layout
extension LoginViewController {

    private func drawView() {
        view.backgroundColor = .primary
        configureHierarchy()
        configureLayout()
    }

    private func configureHierarchy() {
        [loginLabel, introduceLabel].forEach { label in
            loginStackView.addArrangedSubview(label)
        }

        [kakaoLoginButton, facebookLoginButton].forEach { loginButton in
            loginStackView.addArrangedSubview(loginButton)
        }

        view.addSubview(loginStackView)
        view.addSubview(calendarImageView)
    }

    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            calendarImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            calendarImageView.centerYAnchor.constraint(equalTo: safeArea.topAnchor,
                                                       constant: safeArea.layoutFrame.height/3),
            calendarImageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),

            loginStackView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            loginStackView.topAnchor.constraint(equalTo: calendarImageView.bottomAnchor, constant: 20),
            loginStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            loginStackView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier:  0.8),

            kakaoLoginButton.heightAnchor.constraint(equalToConstant: 50),
            facebookLoginButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
