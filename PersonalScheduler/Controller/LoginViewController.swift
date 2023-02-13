//
//  ViewController.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
import FBSDKLoginKit
import AuthenticationServices

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
        return imageView
    }()

    private let facebookLoginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.setImage(UIImage(named: "f_logo_RGB-White_58"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 15, left: -35, bottom: 15, right: 0)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .title3).bold(),
            .foregroundColor: UIColor.white
        ]
        let attributedString = NSAttributedString(string: "페이스북으로 로그인", attributes: attributes)
        button.setAttributedTitle(attributedString, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -95, bottom: 0, right: 0)
        button.backgroundColor = UIColor.init(hex: "#1877F2")
        return button
    }()

    private let appleLoginButton: ASAuthorizationAppleIDButton = {
        let appleButton = ASAuthorizationAppleIDButton(type: .default, style: .black)
        return appleButton
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()

        autoKakaoLogin()
        autoFacebookLogin()
    }
}

// MARK: - Method
private extension LoginViewController {
    func autoKakaoLogin() {
        if AuthApi.hasToken() {
            DispatchQueue.main.async { [weak self] in
                self?.dismiss(animated: true)
                self?.moveScheduleListViewController(.kakao)
            }
        }
    }

    func autoFacebookLogin() {
        if let token = AccessToken.current,
           !token.isExpired {
            DispatchQueue.main.async { [weak self] in
                self?.dismiss(animated: true)
                self?.moveScheduleListViewController(.facebook)
            }
        }
    }

    func moveScheduleListViewController(_ kindOfLogin: KindOfLogin) {
        let scheduleListViewController = ScheduleListViewController()
        scheduleListViewController.kindOfLogin = kindOfLogin
        let navigationController = UINavigationController(rootViewController: scheduleListViewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true)
    }
}

// MARK: - Objc Method
private extension LoginViewController {
    @objc func touchUpKakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { [weak self] oauthToken, error in
                if let error = error {
                    self?.present(AlertManager.shared.showAlert(title: ApiError.loginError.description, message: error.localizedDescription), animated: true)
                    return
                }

                self?.dismiss(animated: true)
                self?.moveScheduleListViewController(.kakao)
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] oauthToken, error in
                if let error = error {
                    self?.present(AlertManager.shared.showAlert(title: ApiError.loginError.description, message: error.localizedDescription), animated: true)
                    return
                }

                self?.dismiss(animated: true)
                self?.moveScheduleListViewController(.kakao)
            }
        }
    }

    @objc func touchUpFacebookLoginButton() {
        let manager = LoginManager()
        manager.logIn(permissions: [], from: self) { [weak self] loginManagerLoginResult, error in
            if let error = error {
                self?.present(AlertManager.shared.showAlert(title: ApiError.loginError.description, message: error.localizedDescription), animated: true)
                return
            }

            guard let result = loginManagerLoginResult else {
                self?.present(AlertManager.shared.showAlert(title: ApiError.loginError.description, message: "No Result"), animated: true)
                return
            }

            if result.isCancelled {
                self?.present(AlertManager.shared.showAlert(title: ApiError.loginError.description, message: "Login Cancelled"), animated: true)
                return
            }

            self?.dismiss(animated: true)
            self?.moveScheduleListViewController(.facebook)
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
            kakaoLoginImageView.heightAnchor.constraint(equalToConstant: buttonHeight),
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
