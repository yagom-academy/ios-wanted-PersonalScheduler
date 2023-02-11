//
//  ViewController.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import FBSDKLoginKit

final class LoginViewController: UIViewController {

    // MARK: - Property
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "스케쥴케어"
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()

    private let kakaoLoginImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "kakao_login_medium_narrow")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let facebookLoginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.backgroundColor = UIColor.init(hex: "#5B7CF2")
        return button
    }()

    private let appleLoginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.backgroundColor = UIColor.init(hex: "#000000")
        return button
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
//        autoFacebookLogin()
    }
}

// MARK: - Method
private extension LoginViewController {
    func autoFacebookLogin() {
        if let token = AccessToken.current,
           !token.isExpired {
            DispatchQueue.main.async { [weak self] in
                self?.moveScheduleListViewController()
            }
        }
    }

    func moveScheduleListViewController() {
        let scheduleListViewController = ScheduleListViewController()
        let navigationController = UINavigationController(rootViewController: scheduleListViewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true)
    }
}

// MARK: - Objc Method
private extension LoginViewController {
    @objc func touchUpKakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    // 에러처리하기
                    print(error)
                    return
                }

                _ = oauthToken
                let accessToken = oauthToken?.accessToken
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] oauthToken, error in
                if let error = error {
                    // 에러처리하기
                    print(error)
                    return
                }

                let accessToken = oauthToken?.accessToken
                self?.moveScheduleListViewController()
            }
        }
    }

    @objc func touchUpFacebookLoginButton() {
        let manager = LoginManager()
        manager.logIn(permissions: [], from: self) { [weak self] loginManagerLoginResult, error in
            if let error = error {
                // 에러처리하기
                print("Process error: \(error)")
                return
            }

            guard let result = loginManagerLoginResult else {
                print("No Result")
                return
            }

            if result.isCancelled {
                print("Login Cancelled")
                return
            }

            let accessToken = result.token
            self?.moveScheduleListViewController()
        }
    }
}

// MARK: - UIConfiguration
private extension LoginViewController {
    func configureUI() {
        [titleLabel,
         kakaoLoginImageView,
         facebookLoginButton,
         appleLoginButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        settingLayouts()

        let kakaoLoginImagetapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpKakaoLogin))
        kakaoLoginImageView.addGestureRecognizer(kakaoLoginImagetapGesture)
        kakaoLoginImageView.isUserInteractionEnabled = true

        facebookLoginButton.addTarget(self, action: #selector(touchUpFacebookLoginButton), for: .touchUpInside)
    }

    func settingLayouts() {
        let smallSpacing: CGFloat = 20
        let buttonHeight: CGFloat = 60

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 4),

            kakaoLoginImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            kakaoLoginImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            kakaoLoginImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: view.frame.height / 4),

            facebookLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            facebookLoginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            facebookLoginButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            facebookLoginButton.topAnchor.constraint(equalTo: kakaoLoginImageView.bottomAnchor, constant: smallSpacing),

            appleLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appleLoginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            appleLoginButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            appleLoginButton.topAnchor.constraint(equalTo: facebookLoginButton.bottomAnchor, constant: smallSpacing)

        ])
    }
}
