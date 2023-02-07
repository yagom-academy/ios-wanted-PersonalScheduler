//
//  LoginViewController.swift
//  PersonalScheduler
//
//  Created by Dragon on 23/02/07.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FBSDKLoginKit
import FBSDKCoreKit
import KakaoSDKUser
import KakaoSDKAuth
import AuthenticationServices

class LoginViewController: UIViewController {
    
    // MARK: Private Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.text = "개인 일정 관리 \n (Personal Scheduler)"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    private let loginGuideLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.text = "SNS 계정으로 간편 로그인하기"
        label.textAlignment = .center
        label.textColor = .systemGray4
        return label
    }()
    private let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "KakaoLogin.png"), for: .normal)
        return button
    }()
    private let facebookLoginButton: FBLoginButton = {
        let button = FBLoginButton()
        return button
    }()
    private let appleLoginButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        return button
    }()
    private let loginErrorButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인에 문제가 있나요?", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .callout)
        return button
    }()
    private let loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = 10
        return stackView
    }()
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkToken()
        configureView()
        configureLayout()
        configureButtonAction()
        facebookLoginButton.delegate = self
    }
    
    private func checkToken() {
        if let token = AccessToken.current,
           !token.isExpired {
            
            dismiss(animated: true)
        }
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureButtonAction() {
        kakaoLoginButton.addTarget(self, action: #selector(tapKakaoLoginButton), for: .touchDown)
        appleLoginButton.addTarget(self, action: #selector(tapKakaoLoginButton), for: .touchDown)
    }
    
    private func getUserInfo() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                
                
                let nickname = user?.kakaoAccount?.profile?.nickname
                let email = user?.kakaoAccount?.email
                
                self.dismiss(animated: true)
            }
        }
    }
    
    private func setUpStackView() {
        loginStackView.addArrangedSubview(loginGuideLabel)
        loginStackView.addArrangedSubview(kakaoLoginButton)
        loginStackView.addArrangedSubview(facebookLoginButton)
        loginStackView.addArrangedSubview(appleLoginButton)
        loginStackView.addArrangedSubview(loginErrorButton)
        
        totalStackView.addArrangedSubview(titleLabel)
        totalStackView.addArrangedSubview(loginStackView)
    }

    private func configureLayout() {
        setUpStackView()
        
        view.addSubview(totalStackView)
        
        NSLayoutConstraint.activate([
            kakaoLoginButton.widthAnchor.constraint(equalTo: loginStackView.widthAnchor, multiplier: 0.9),
            kakaoLoginButton.heightAnchor.constraint(equalTo: loginStackView.heightAnchor, multiplier: 0.18),
            
            facebookLoginButton.widthAnchor.constraint(equalTo: loginStackView.widthAnchor, multiplier: 0.9),
            facebookLoginButton.heightAnchor.constraint(equalTo: loginStackView.heightAnchor, multiplier: 0.18),
            
            appleLoginButton.widthAnchor.constraint(equalTo: loginStackView.widthAnchor, multiplier: 0.9),
            appleLoginButton.heightAnchor.constraint(equalTo: loginStackView.heightAnchor, multiplier: 0.18),
            
            loginStackView.widthAnchor.constraint(equalTo: totalStackView.widthAnchor, multiplier: 0.9),
            loginStackView.heightAnchor.constraint(equalTo: totalStackView.heightAnchor, multiplier: 0.45),
            
            totalStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            totalStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.85),
            totalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            totalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc
    private func tapKakaoLoginButton() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    _ = oauthToken
                    self.getUserInfo()
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    _ = oauthToken
                    self.getUserInfo()
                }
            }
        }
    }
    
    @objc
    private func tapAppleLoginButton() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
    }
}

extension LoginViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        dismiss(animated: true)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {}
}
