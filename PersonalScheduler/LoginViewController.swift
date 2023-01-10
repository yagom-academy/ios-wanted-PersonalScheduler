//
//  LoginViewController.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import FacebookLogin
import KakaoSDKUser
import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: Properties
    
    private let facebookButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("페이스북 로그인", for: .normal)
        button.backgroundColor = .systemBlue
        
        return button
    }()
    
    private let kakaoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemYellow
        button.setImage(UIImage(named: "kakaoLogin"), for: .normal)
        
        return button
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
    }
    
    // MARK: - Methods
    
    private func commonInit() {
        setupBackgroundColor(.systemBackground)
        setupSubviews()
        setupConstraints()
        setupKakaoButton()
        setupFacebookButton()
        setupFacebookButton()
    }
    
    private func setupBackgroundColor(_ color: UIColor?) {
        view.backgroundColor = color
    }
    
    private func setupSubviews() {
        [kakaoButton, facebookButton]
            .forEach { view.addSubview($0) }
    }
    
    private func setupConstraints() {
        setupKakaoButtonConstraints()
        setupFacebookButtonConstraints()
    }
    
    private func setupKakaoButtonConstraints() {
        NSLayoutConstraint.activate([
            kakaoButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            kakaoButton.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            )
        ])
        kakaoButton.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    }
    
    private func setupFacebookButtonConstraints() {
        NSLayoutConstraint.activate([
            facebookButton.topAnchor.constraint(
                equalTo: kakaoButton.bottomAnchor,
                constant: 20
            ),
            facebookButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            facebookButton.widthAnchor.constraint(
                equalTo: kakaoButton.widthAnchor
            ),
            facebookButton.heightAnchor.constraint(
                equalTo: kakaoButton.heightAnchor
            )
        ])
    }
    
    private func setupKakaoButton() {
        kakaoButton.addTarget(
            self,
            action: #selector(kakaoButtonDidTap),
            for: .touchUpInside
        )
    }
    
    private func setupFacebookButton() {
        facebookButton.addTarget(
            self,
            action: #selector(facebookButtonDidTap),
            for: .touchUpInside
        )
    }
    
    @objc
    private func kakaoButtonDidTap() {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                /// alertController
                print(error)
            }
            else {
                UserApi.shared.me { (user, error) in
                    if let error = error {
                        /// alertController
                        print(error)
                    } else {
                        /// Next ViewController
                        print(user?.id)
                    }
                }
            }
        }
    }
    
    @objc
    private func facebookButtonDidTap() {
        let loginManager = LoginManager()

        loginManager.logIn(
            permissions: ["public_profile", "email"],
            from: self
        ) { result, error in
            if let error = error {
                /// alertController
            } else {
                /// NextViewController
            }
        }
    }
    
}

