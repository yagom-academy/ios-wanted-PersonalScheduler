//
//  LoginViewController.swift
//  PersonalScheduler
//
//  Created by Kyo on 2023/02/07.
//

import UIKit

final class LoginViewController: UIViewController {
    private let viewModel: LoginViewModel

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
        let listViewController = ListViewController(ListViewModel(FireStoreManager(.kakao)))
        viewModel.loginKakao { result in
            if result {
                self.navigationController?.pushViewController(listViewController, animated: true)
            }
        }
    }
    
    @objc private func facebookLoginTapped() {
        viewModel.faceBookLogin { result in
            let listViewController = ListViewController(ListViewModel(FireStoreManager(.faceBook)))
            if result {
                self.navigationController?.pushViewController(listViewController, animated: true)
            }
        }
    }
}

// MARK: - UIConstraint
extension LoginViewController {
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = true
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
            loginImageView.topAnchor.constraint(
                equalTo: safeArea.topAnchor, constant: 100
            ),
            loginImageView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor, constant: 30
            ),
            loginImageView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor, constant: -30
            ),
            
            kakaoLoginButton.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor, constant: 70
            ),
            kakaoLoginButton.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor, constant: -70
            ),
            kakaoLoginButton.topAnchor.constraint(
                equalTo: loginImageView.bottomAnchor,
                constant: 50
            ),
            
            faceBookLoginButton.topAnchor.constraint(
                equalTo: kakaoLoginButton.bottomAnchor, constant: 5
            ),
            faceBookLoginButton.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor, constant: 10
            ),
            faceBookLoginButton.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor, constant: -10
            ),
        ])
    }
}
