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
import KakaoSDKCommon
import KakaoSDKUser
import KakaoSDKAuth
import AuthenticationServices

class LoginViewController: UIViewController {
    
    // MARK: Private Enumeration
    
    private enum SNSType {
        case normal
        case kakao
        case facebook
        case apple
    }
    
    // MARK: Private Properties
    
    private let normalLoginView = NormalLoginView(frame: .zero, mode: .login)
    private let normalLoginViewCreateMode = NormalLoginView(frame: .zero, mode: .create)
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline).withSize(20)
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
        button.isSelected = false
        return button
    }()
    private let appleLoginButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        return button
    }()
    private let snsLoginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        return stackView
    }()
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureLayout()
        configureButtonAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        configureDelegate()
    }
    
    func toggleFacebookLoginButton() {
        FBSDKLoginKit.LoginManager().logOut()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureDelegate() {
        normalLoginView.delegate = self
    }
    
    private func configureButtonAction() {
        facebookLoginButton.delegate = self
        
        kakaoLoginButton.addTarget(self, action: #selector(tapKakaoLoginButton), for: .touchDown)
        appleLoginButton.addTarget(self, action: #selector(tapKakaoLoginButton), for: .touchDown)
    }
    
    private func configureDomainName(type: SNSType) -> String {
        switch type {
        case .normal:
            return String()
        case .kakao:
            return "@kakaologin.com"
        case .facebook:
            return "@facebooklogin.com"
        case .apple:
            return "@applelogin.com"
        }
    }
    
    private func checkAuthLogIn(type: SNSType, id: String, password: String) {
        let domainName = configureDomainName(type: type)
        
        Auth.auth().createUser(withEmail: String(id) + domainName, password: password) { authResult, error in
            if let error = error {
                print(error)
                self.signInAuth(type: type, id: id, password: password)
            } else {
                self.dismiss(animated: true)
            }
        }
    }
    
    private func signInAuth(type: SNSType, id: String, password: String) {
        let domainName = configureDomainName(type: type)
        
        Auth.auth().signIn(withEmail: String(id) + domainName, password: password) { authResult, error in
            if let error = error {
                print(error)
            } else {
                self.dismiss(animated: true)
            }
        }
    }
    
    private func getUserInfo() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            } else {
                if let id = user?.id {
                    let stringID = String(id)
                    self.checkAuthLogIn(type: .kakao, id: stringID, password: stringID)
                }
            }
        }
    }
    
    private func setUpStackView() {
        snsLoginStackView.addArrangedSubview(loginGuideLabel)
        snsLoginStackView.addArrangedSubview(kakaoLoginButton)
        snsLoginStackView.addArrangedSubview(facebookLoginButton)
        snsLoginStackView.addArrangedSubview(appleLoginButton)
        
        totalStackView.addArrangedSubview(titleLabel)
        totalStackView.addArrangedSubview(normalLoginView)
        totalStackView.addArrangedSubview(snsLoginStackView)
    }
    
    private func configureLayout() {
        setUpStackView()
        
        view.addSubview(totalStackView)
        
        NSLayoutConstraint.activate([
            normalLoginView.widthAnchor.constraint(equalTo: totalStackView.widthAnchor, multiplier: 0.9),
            normalLoginView.heightAnchor.constraint(equalTo: totalStackView.heightAnchor, multiplier: 0.3),
            
            snsLoginStackView.widthAnchor.constraint(equalTo: totalStackView.widthAnchor, multiplier: 0.8),
            snsLoginStackView.heightAnchor.constraint(equalTo: totalStackView.heightAnchor, multiplier: 0.35),
            
            totalStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            totalStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.85),
            totalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            totalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc
    private func tapKakaoLoginButton() {
        if UserApi.isKakaoTalkLoginAvailable() {
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
            print(error)
        } else {
            if let result = result {
                if let id = result.token?.userID {
                    self.checkAuthLogIn(type: .facebook, id: id, password: id)
                }
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {}
}

extension LoginViewController: UserInfoSendable {
    func createUserInfo(id: String, password: String) {
        checkAuthLogIn(type: .normal, id: id, password: password)
    }
    
    func presentCreateUserInfoView() {
        let pushViewController = CreateUserInfoViewController()
        
        navigationController?.pushViewController(pushViewController, animated: true)
        navigationItem.backButtonTitle = "뒤로가기"
    }
    
    func signInUserInfo(id: String, password: String) {
        signInAuth(type: .normal, id: id, password: password)
    }
}
