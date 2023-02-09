//
//  LoginViewController.swift
//  PersonalScheduler
//
//  Created by Kyo on 2023/02/07.
//

import UIKit

final class LoginViewController: UIViewController {
    private let viewModel: LoginViewModel
    private var fireStoreManager: FireStoreManager?
    
    private let loginImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let faceBookLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "facebook_login_image"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstrinat()
    }
}

// MARK: - Button Action
extension LoginViewController {
    @objc private func kakaoLoginTapped() {
        viewModel.loginKakao()
        fireStoreManager = FireStoreManager(social: .kakao)
    }
    
    @objc private func facebookLoginTapped() {
        viewModel.faceBookLogin()
        fireStoreManager = FireStoreManager(social: .faceBook)
    }
}

// MARK: - UIConstraint
extension LoginViewController {
    private func setupView() {
        view.backgroundColor = .systemBackground
        loginImageView.image = UIImage(named: "logo")
        kakaoLoginButton.setImage(UIImage(named: "kakao_login_image"), for: .normal)
        kakaoLoginButton.addTarget(
            self,
            action: #selector(kakaoLoginTapped),
            for: .touchUpInside
        )
        faceBookLoginButton.addTarget(
            self,
            action: #selector(facebookLoginTapped),
            for: .touchUpInside
        )
        [loginImageView, kakaoLoginButton, faceBookLoginButton].forEach(view.addSubview(_:))
    }
    
    private func setupConstrinat() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            loginImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 100),
            loginImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 30),
            loginImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -30),
            
            kakaoLoginButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            kakaoLoginButton.topAnchor.constraint(
                equalTo: loginImageView.bottomAnchor,
                constant: 50
            ),
            
            faceBookLoginButton.topAnchor.constraint(equalTo: kakaoLoginButton.bottomAnchor, constant: 20),
            faceBookLoginButton.leadingAnchor.constraint(equalTo: kakaoLoginButton.leadingAnchor),
            faceBookLoginButton.trailingAnchor.constraint(equalTo: kakaoLoginButton.trailingAnchor)
        ])
    }
}
