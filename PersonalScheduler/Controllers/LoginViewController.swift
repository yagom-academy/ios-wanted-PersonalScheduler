//
//  LoginViewController.swift
//  PersonalScheduler
//
//  Created by junho lee on 2023/02/08.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FacebookLogin
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

final class LoginViewController: UIViewController {
    private let activityIndicatorView = UIActivityIndicatorView()
    private let titleLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .largeTitle))
    private let facebookLoginButton = {
        let button = FBLoginButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let kakaoLoginButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: Constants.kakaoButtonImage), for: .normal)
        return button
    }()
    private let stackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = Constants.stackViewSpacing
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        titleLabel.text = Constants.title
        configureActivityIndicator()
        configureLoginButton()
        configureHierarchy()
        showListViewIfLoggedIn()
    }

    private func configureLoginButton() {
        facebookLoginButton.delegate = self
        kakaoLoginButton.addAction(UIAction(handler: kakaoLoginHandler), for: .touchUpInside)
    }

    private func kakaoLoginHandler(_ action: UIAction) {
        if UserApi.isKakaoTalkLoginAvailable() {
            loginWithKakaoTalk()
        } else {
            loginWithKakaoAccount()
        }
    }

    private func configureActivityIndicator() {
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .large
    }

    private func configureHierarchy() {
        stackView.addArrangedSubview(facebookLoginButton)
        stackView.addArrangedSubview(kakaoLoginButton)
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(activityIndicatorView)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -50.0),

            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: Constants.stackViewHeight)
        ])
    }

    private func showListViewIfLoggedIn() {
        if Auth.auth().currentUser != nil {
            showListViewController()
        }
    }

    private func startLoadingAnimation() {
        DispatchQueue.main.async {
            self.activityIndicatorView.startAnimating()
            self.view.isUserInteractionEnabled = false
        }
    }

    private func stopLoadingAnimation() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
}

extension LoginViewController: LoginButtonDelegate {
    func loginButton(
        _ loginButton: FBSDKLoginKit.FBLoginButton,
        didCompleteWith result: FBSDKLoginKit.LoginManagerLoginResult?,
        error: Error?) {
            if let error {
                print(error.localizedDescription)
                stopLoadingAnimation()
                return
            }
            guard let tokenString = AccessToken.current?.tokenString else { return }
            let credential = FacebookAuthProvider.credential(withAccessToken: tokenString)
            firebaseLogin(credential)
        }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}

extension LoginViewController {
    private func loginWithKakaoTalk() {
        UserApi.shared.loginWithKakaoTalk { [weak self] _, error in
            guard let self else { return }
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoTalk() success.")
                self.firebaseLoginWithKakaoUserInfo()
            }
        }
    }

    private func loginWithKakaoAccount() {
        UserApi.shared.loginWithKakaoAccount { [weak self] _, error in
            guard let self else { return }
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoTalk() success.")
                self.firebaseLoginWithKakaoUserInfo()
            }
        }
    }
}

extension LoginViewController {
    private func firebaseLogin(_ credential: AuthCredential) {
        startLoadingAnimation()
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            guard let self else { return }
            if let error {
                let authError = error as NSError
                print(authError.localizedDescription)
                self.stopLoadingAnimation()
            }
            self.showListViewController()
        }
    }

    private func firebaseLoginWithEmail(_ email: String, password: String) {
        startLoadingAnimation()
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self else { return }
            if let error = error as NSError? {
                if error.code == AuthErrorCode.userNotFound.rawValue {
                    Auth.auth().createUser(withEmail: email, password: password) { result, error in
                        if let error {
                            print(error.localizedDescription)
                            self.stopLoadingAnimation()
                            return
                        }
                        self.showListViewController()
                        return
                    }
                } else {
                    print(error.localizedDescription)
                    self.stopLoadingAnimation()
                    return
                }
            } else {
                self.showListViewController()
            }
        }
    }

    private func firebaseLoginWithKakaoUserInfo() {
        UserApi.shared.me() { [weak self] user, error in
            guard let self else { return }
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let user = user,
                  let email = user.kakaoAccount?.email else { return }
            let password = String(describing: user.id)
            self.firebaseLoginWithEmail(email, password: password)
        }
    }

    private func showListViewController() {
        DispatchQueue.main.async {
            let viewController = ListViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
            self.stopLoadingAnimation()
        }
    }
}

extension LoginViewController {
    private enum Constants {
        static let title = "Personal Scheduler"
        static let kakaoButtonImage = "kakao_login_wide"
        static let stackViewSpacing = 10.0
        static let stackViewHeight = 100.0
    }
}
