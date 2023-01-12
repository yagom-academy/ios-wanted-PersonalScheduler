//
//  LoginViewController.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

import UIKit
import FirebaseAuth
import FacebookLogin

final class LoginViewController: UIViewController {
    private let loginView = LoginView()
    private let viewModel: LoginViewModel
    private var handle: AuthStateDidChangeListenerHandle?
    
    init(with viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        setupButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setupInitialView() {
        view = loginView
    }
    
    private func setupButton() {
        loginView.loginButton.addTarget(
            self,
            action: #selector(loginButtonTapped),
            for: .touchUpInside
        )
        
        loginView.signInButton.addTarget(
            self,
            action: #selector(signInButtonTapped),
            for: .touchUpInside
        )
        
        loginView.kakaoLogoImageButton.addTarget(
            self,
            action: #selector(kakaoButtonTapped),
            for: .touchUpInside
        )
        
        loginView.facebookLogoImageButton.addTarget(
            self,
            action: #selector(facebookButtonTapped),
            for: .touchUpInside
        )
        
        loginView.appleLogoImageButton.addTarget(
            self,
            action: #selector(appleButtonTapped),
            for: .touchUpInside
        )
    }
    
    private func compareWithServerInfo(_ loginInfo: LoginInfo) async {
        do {
            try await viewModel.validateLoginInfo(loginInfo)
        } catch {
            AlertBuilder(title: "알람",
                         message: "사용자를 찾을 수 없습니다.",
                         preferredStyle: .alert)
            .setButton(name: "확인", style: .default)
            .showAlert(on: self)
        }
    }
    
    @objc private func loginButtonTapped() {
        guard let loginInfo = loginView.retrieveLoginInfo() else {
            return
        }
        do {
            try loginInfo.validate()
            Task {
                await compareWithServerInfo(loginInfo)
            }
        } catch let error as LoginError {
            AlertBuilder(title: "경고",
                         message: error.description,
                         preferredStyle: .alert)
            .setButton(name: "예", style: .default)
            .showAlert(on: self)
        } catch {
            print(String(describing: error))
        }
    }
    
    @objc private func signInButtonTapped() {
        viewModel.signinButtonTapped()
    }
    
    @objc private func kakaoButtonTapped() {
        viewModel.kakaoLogoButtonTapped()
    }
    
    @objc private func facebookButtonTapped() {
        viewModel.facebookLoginButtonTapped(in: self)
    }
    
    @objc private func appleButtonTapped() {
        AlertBuilder(title: "경고", message: "현재 사용할 수 없습니다.", preferredStyle: .alert)
            .setButton(name: "확인", style: .default)
            .showAlert(on: self)
    }
}
