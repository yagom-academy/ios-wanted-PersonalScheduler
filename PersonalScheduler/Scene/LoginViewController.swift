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
    
    private let idTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "아이디"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "비밀번호"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
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
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
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
        setupLoginButton()
    }
    
    private func setupBackgroundColor(_ color: UIColor?) {
        view.backgroundColor = color
    }
    
    private func setupSubviews() {
        [idTextField, passwordTextField, kakaoButton, facebookButton, loginButton]
            .forEach { view.addSubview($0) }
    }
    
    private func setupConstraints() {
        setupIDTextFieldConstraints()
        setupPasswordTextFieldConstraints()
        setupKakaoButtonConstraints()
        setupFacebookButtonConstraints()
        setupLoginButtonConstraints()
    }
    
    private func setupIDTextFieldConstraints() {
        NSLayoutConstraint.activate([
            idTextField.bottomAnchor.constraint(
                equalTo: passwordTextField.topAnchor,
                constant: -12
            ),
            idTextField.widthAnchor.constraint(
                equalTo: kakaoButton.widthAnchor
            ),
            idTextField.centerXAnchor.constraint(
                equalTo: kakaoButton.centerXAnchor
            )
        ])
    }
    
    private func setupPasswordTextFieldConstraints() {
        NSLayoutConstraint.activate([
            passwordTextField.bottomAnchor.constraint(
                equalTo: kakaoButton.topAnchor,
                constant: -20
            ),
            passwordTextField.widthAnchor.constraint(
                equalTo: kakaoButton.widthAnchor
            ),
            passwordTextField.centerXAnchor.constraint(
                equalTo: kakaoButton.centerXAnchor
            )
        ])
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
    
    private func setupLoginButtonConstraints() {
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(
                equalTo: facebookButton.bottomAnchor,
                constant: 20
            ),
            loginButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
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
    
    private func setupLoginButton() {
        loginButton.addTarget(
            self,
            action: #selector(loginButtonDidTap),
            for: .touchUpInside
        )
    }
    
    @objc
    private func kakaoButtonDidTap() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    self.setupKakaoUserInfo()
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    self.setupKakaoUserInfo()
                }
            }
        }
    }
    
    private func setupKakaoUserInfo() {
        UserApi.shared.me { user, error in
            if let error = error {
                print(error)
            }
            self.idTextField.text = user?.kakaoAccount?.email
            self.passwordTextField.text = "●●●●●●●"
        }
    }
    
    @objc
    private func facebookButtonDidTap() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.email]) { result in
            switch result {
            case .cancelled:
                print("Login Canceled")
            case .failed(let error):
                print(error)
            case .success(_, _, _):
                GraphRequest.init(
                    graphPath: "me",
                    parameters: ["fields": "email"]
                ).start { connection, result, error in
                    if let error = error {
                        print(error)
                    }
                    
                    let userInfo = result as? [String: Any]
                    let email = userInfo?["email"] as? String
                    
                    self.idTextField.text = email
                    self.passwordTextField.text = "●●●●●●●"
                }
            }
        }
    }
    
    @objc
    private func loginButtonDidTap() {
        let scheduleViewController = ScheduleViewController()
        self.present(scheduleViewController, animated: true)
    }
}
