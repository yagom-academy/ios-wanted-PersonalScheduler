//
//  LoginViewController.swift
//  PersonalScheduler
//
//  Created by unchain on 06/01/23.
//

import UIKit
import FirebaseFirestore
import Combine
import KakaoSDKAuth

final class LoginViewController: UIViewController {
    private let loginViewModel: LoginViewModel
    private var cancelable = Set<AnyCancellable>()

    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "kakao_login_large_wide"), for: .normal)
        button.addTarget(self, action: #selector(tappedKakaoLoginButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var stackView: UIStackView =  {
        let stack = UIStackView()
        stack.spacing = 8
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        bind()

        stackView.addArrangedSubview(kakaoLoginButton)
        view.addSubview(stackView)
        setConstraint()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loginViewModel.autoLogin()
    }

    func setConstraint() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
}

extension LoginViewController {
    private func bind() {
        loginViewModel.kakaoLoginPublisher
            .sink { [weak self] model in
                guard let self = self else { return }
                self.navigationController?.pushViewController(
                    ListViewController(),
                    animated: true
                )
            }
            .store(in: &cancelable)
    }

    @objc private func tappedKakaoLoginButton() {
        loginViewModel.input.tappedKaKaoButton()
    }
}
