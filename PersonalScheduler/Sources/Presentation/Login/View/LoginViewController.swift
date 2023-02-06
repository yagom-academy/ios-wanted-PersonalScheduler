//
//  LoginViewController.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit
import FacebookLogin

final class LoginViewController: UIViewController {
    private let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("카카오로 로그인하기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let faceBookButton: FBLoginButton = {
        let button = FBLoginButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.permissions = ["public_profile", "email"]
        return button
    }()
    
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setButtonAction()
        
        if let token = AccessToken.current,
           token.isExpired == false {
            print(token)
        }
    }
}

private extension LoginViewController {
    func setButtonAction() {
        kakaoLoginButton.addTarget(self, action: #selector(didTapKakaoLogin), for: .touchUpInside)
        faceBookButton.addTarget(self, action: #selector(didTapFaceBookLogin), for: .touchUpInside)
    }
    
    @objc func didTapKakaoLogin() {
        viewModel.loginKakao()
    }
    
    @objc func didTapFaceBookLogin() {
        LoginManager().logIn(permissions: ["public_profile"], from: self) { result, error in
            if let error = error {
                print("Error in \(error)")
            } else if let result = result, result.isCancelled {
                print("Canceled")
            } else {
                print("logged in")
            }
        }
    }
}

private extension LoginViewController {
    func configureUI() {
        addChildComponents()
        setUpLayout()
    }
    
    func addChildComponents() {
        [kakaoLoginButton, faceBookButton].forEach(view.addSubview)
    }
    
    func setUpLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            kakaoLoginButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            kakaoLoginButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            kakaoLoginButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -200),
            
            faceBookButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            faceBookButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            faceBookButton.topAnchor.constraint(equalTo: kakaoLoginButton.bottomAnchor, constant: 20)
        ])
    }
}

