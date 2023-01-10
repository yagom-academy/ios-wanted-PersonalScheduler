//
//  LoginViewController.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import KakaoSDKUser
import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: Properties
    
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
    }
    
    private func setupBackgroundColor(_ color: UIColor?) {
        view.backgroundColor = color
    }
    
    private func setupSubviews() {
        view.addSubview(kakaoButton)
    }
    
    private func setupConstraints() {
        setupKakaoButtonConstraints()
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
    }
    
    private func setupKakaoButton() {
        kakaoButton.addTarget(
            self,
            action: #selector(kakaoButtonDidTap),
            for: .touchUpInside
        )
    }
    
    @objc
    private func kakaoButtonDidTap() {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                /// alertController
            }
            else {
                /// Next ViewController
            }
        }
    }
    
}

