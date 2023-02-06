//
//  LoginView.swift
//  PersonalScheduler
//
//  Created by Dragon on 23/02/07.
//

import UIKit
import FBSDKLoginKit
import KakaoSDKUser
import AuthenticationServices

class LoginView: UIView {
    
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
        label.text = "SNS 계정으로 간편 가입하기"
        label.textAlignment = .center
        label.textColor = .systemGray4
        return label
    }()
    private let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "KakaoLogin.png"), for: .normal)
        return button
    }()
    private let facebookLoginButton = FBLoginButton()
    private let appleLoginButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(type: .signIn, style: .whiteOutline)
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
    
    // MARK: Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureLayout()
        configureButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
    }
    
    private func configureButtonAction() {
        kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginAction), for: .touchDown)
        appleLoginButton.addTarget(self, action: #selector(kakaoLoginAction), for: .touchDown)
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
        
        addSubview(totalStackView)
        
        NSLayoutConstraint.activate([
            kakaoLoginButton.widthAnchor.constraint(equalTo: loginStackView.widthAnchor),
            kakaoLoginButton.heightAnchor.constraint(equalTo: loginStackView.heightAnchor, multiplier: 0.18),
            
            facebookLoginButton.widthAnchor.constraint(equalTo: loginStackView.widthAnchor),
            facebookLoginButton.heightAnchor.constraint(equalTo: loginStackView.heightAnchor, multiplier: 0.18),
            
            appleLoginButton.widthAnchor.constraint(equalTo: loginStackView.widthAnchor),
            appleLoginButton.heightAnchor.constraint(equalTo: loginStackView.heightAnchor, multiplier: 0.18),
            
            loginStackView.widthAnchor.constraint(equalTo: totalStackView.widthAnchor),
            loginStackView.heightAnchor.constraint(equalTo: totalStackView.heightAnchor, multiplier: 0.5),
            
            totalStackView.widthAnchor.constraint(equalTo: widthAnchor),
            totalStackView.heightAnchor.constraint(equalTo: heightAnchor),
            totalStackView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    @objc
    private func kakaoLoginAction() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    _ = oauthToken
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    _ = oauthToken
                }
            }
        }
    }
    
    @objc
    private func appleLoginAction() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
    }
}
