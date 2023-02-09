//
//  LoginViewController.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/06.
//

import UIKit

import FacebookLogin
import FirebaseAuth

class LoginViewController: UIViewController {
    private let facebookLoginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yellow
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureView()
        configureLayout()
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            facebookLoginButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            facebookLoginButton.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            kakaoLoginButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            kakaoLoginButton.topAnchor.constraint(equalTo: facebookLoginButton.bottomAnchor, constant: 12)
        ])
    }
    
    private func configureView() {
        facebookLoginButton.addAction(UIAction(handler: tapFacebookLogin), for: .touchUpInside)
        kakaoLoginButton.addAction(UIAction(handler: tapKakaoLogin), for: .touchUpInside)
        viewModel.delegate = self
        
        view.addSubview(facebookLoginButton)
        view.addSubview(kakaoLoginButton)
    }
    
    private func tapFacebookLogin(_ action: UIAction) {
        viewModel.action(.tapFacebookLogin)
    }
    
    private func tapKakaoLogin(_ action: UIAction) {
        viewModel.action(.tapKakaoLogin)
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func loginViewModel(successLogin uid: String) {
        print(uid)
    }
    
    func loginViewModel(failedLogin error: Error) {
        print(error.localizedDescription)
    }
    
    func loginViewModel(successLogout: Void) {
        
    }
    
    func loginViewModel(failedLogout error: Error) {
        print(error.localizedDescription)
        
    }
}
