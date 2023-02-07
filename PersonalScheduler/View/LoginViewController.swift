//
//  LoginViewController.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 06/01/23.
//

import UIKit

final class LoginViewController: UIViewController {

    private let loginLabel = UILabel(text: "Login", font: .largeTitle, fontBold: true, textColor: .navy)
    private let introduceLabel = UILabel(text: "and save your Schedule", textColor: .secondary)

    private let calendarImageView: UIImageView = {
        let calendarImage = UIImage(named: "Calendar")
        let imageView = UIImageView(image: calendarImage)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private lazy var LoginButton = { (image: UIImage?, action: Selector) -> UIButton in
        let button = UIButton(frame: .zero)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }

    private let loginStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layer.cornerRadius = 30
        stack.distribution = .fillProportionally
        stack.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.backgroundColor = .tertiary

        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        drawView()
    }

    private func generateLoginButtons() -> [UIButton] {
        let kakaoLoginImage = UIImage(named: "KakaoLogin")
        let kakaoLoginButton = self.LoginButton(kakaoLoginImage, #selector(loginWidthKakao))

        return [kakaoLoginButton]
    }

    @objc private func loginWidthKakao() {
        //구현예정: 카카오 로그인
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
        generateLoginButtons().forEach { loginButton in
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
                                                       constant: safeArea.layoutFrame.height/4),
            calendarImageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),

            loginStackView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            loginStackView.topAnchor.constraint(equalTo: calendarImageView.bottomAnchor, constant: 20),
            loginStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            loginStackView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier:  0.8),
        ])
    }
}
