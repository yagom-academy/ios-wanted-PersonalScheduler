//
//  LoginViewController.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit
import FacebookLogin
import AppTrackingTransparency

final class LoginViewController: UIViewController {
    private let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("카카오로 로그인하기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let facebookLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("facebook으로 로그인하기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setButtonAction()
        
        if let token = AccessToken.current {
            print(token)
        }
    }
}

private extension LoginViewController {
    func setButtonAction() {
        kakaoLoginButton.addTarget(self, action: #selector(didTapKakaoLogin), for: .touchUpInside)
        facebookLoginButton.addTarget(self, action: #selector(didTapFaceBookLogin), for: .touchUpInside)
    }
    
    @objc func didTapKakaoLogin() {
        viewModel.loginKakao()
    }
    
    @objc func didTapFaceBookLogin() {
        viewModel.faceBookLogin(from: self) { result in
            // TODO: - Handling Token
        }
    }
}

private extension LoginViewController {
    func configureUI() {
        addChildComponents()
        setUpLayout()
    }
    
    func addChildComponents() {
        [kakaoLoginButton, facebookLoginButton].forEach(view.addSubview)
    }
    
    func setUpLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            kakaoLoginButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            kakaoLoginButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            kakaoLoginButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -200),
            
            facebookLoginButton.leadingAnchor.constraint(equalTo: kakaoLoginButton.leadingAnchor),
            facebookLoginButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            facebookLoginButton.topAnchor.constraint(equalTo: kakaoLoginButton.bottomAnchor, constant: 30)
        ])
    }
}

