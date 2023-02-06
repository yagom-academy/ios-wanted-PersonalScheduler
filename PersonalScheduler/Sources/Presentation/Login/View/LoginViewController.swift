//
//  LoginViewController.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit

final class LoginViewController: UIViewController {
    private let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("카카오로 로그인하기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setButtonAction()
    }
}

private extension LoginViewController {
    func setButtonAction() {
        kakaoLoginButton.addTarget(self, action: #selector(didTapKakaoLogin), for: .touchUpInside)
    }
    
    @objc func didTapKakaoLogin() {
        print("did Tap Kakao Login")
    }
}

private extension LoginViewController {
    func configureUI() {
        addChildComponents()
        setUpLayout()
    }
    
    func addChildComponents() {
        [kakaoLoginButton,].forEach(view.addSubview)
    }
    
    func setUpLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            kakaoLoginButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            kakaoLoginButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            kakaoLoginButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -200)
        ])
    }
}

