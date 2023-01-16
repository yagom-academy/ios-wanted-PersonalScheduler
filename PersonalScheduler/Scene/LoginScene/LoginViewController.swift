//
//  LoginViewController.swift
//  PersonalScheduler
//
//  Created by Judy on 2023/01/12.
//

import UIKit
import KakaoSDKUser
import FacebookLogin
import FirebaseAuth

final class LoginViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.font = .boldSystemFont(ofSize: label.font.pointSize)
        label.textColor = .label
        label.textAlignment = .center
        label.text = ScheduleInfo.Notice.startScheduleManagement
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.text = ScheduleInfo.Notice.autoLogin
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(ScheduleImage.kakaoButton, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let facebookLoginButton = FBLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addLoginButtonTarget()
        facebookLoginButton.delegate = self
    }
    
    private func setupView() {
        let spacingView = UIView()
        spacingView.translatesAutoresizingMaskIntoConstraints = false

        if let heightConstraint = facebookLoginButton.constraints
            .first(where: { $0.firstAttribute == .height }) {
            facebookLoginButton.removeConstraint(heightConstraint)
        }

        loginStackView.addArrangedSubview(titleLabel)
        loginStackView.addArrangedSubview(infoLabel)
        loginStackView.addArrangedSubview(spacingView)
        loginStackView.addArrangedSubview(facebookLoginButton)
        loginStackView.addArrangedSubview(kakaoLoginButton)
        
        view.addSubview(loginStackView)
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            loginStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                    constant: 16),
            loginStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                     constant: -16),
            loginStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
    
            facebookLoginButton.heightAnchor.constraint(equalTo: kakaoLoginButton.heightAnchor),
            facebookLoginButton.widthAnchor.constraint(equalTo: kakaoLoginButton.widthAnchor),
            
            spacingView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor,
                                                multiplier: 1/4)
        ])
    }
    
    private func addLoginButtonTarget() {
        kakaoLoginButton.addTarget(self,
                                   action: #selector(kakaoLoginButtonTapped),
                                   for: .touchUpInside)
    }
    
    private func presentScheduleListView() {
        guard let user = Auth.auth().currentUser else { return }
        
        let scheduleViewModel = ScheduleViewModel(with: user.uid)
        let scheduleListView = ScheduleListViewController(scheduleViewModel)
        let navigationController = UINavigationController(rootViewController: scheduleListView)
    
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    private func createKakaoUser() {
        UserApi.shared.me() { [weak self] user, error in
            if error != nil {
                self?.showAlert(.kakaoLoginFailed)
                return
            }

            guard let user = user,
                  let email = user.kakaoAccount?.email else {
                self?.showAlert(.kakaoLoginFailed)
                return
            }
            
            let password = String(describing: user.id)
            
            Auth.auth().signIn(withEmail: email,
                               password: password) { result, error in
                if error != nil {
                    Auth.auth().createUser(withEmail: email,
                                           password: password) { result, error in
                        if error != nil {
                            self?.showAlert(.kakaoLoginFailed)
                            return
                        }
                    }
                    return
                }
                
                LoginManager.shared.saveKakaoLogin(id: email, password: password)
                self?.presentScheduleListView()
            }
        }
    }
    
    @objc private func kakaoLoginButtonTapped() {
        UserApi.shared.loginWithKakaoAccount { [weak self] oauthToken, error in
            if error != nil {
                self?.showAlert(.kakaoLoginFailed)
            } else {
                self?.createKakaoUser()
            }
        }
    }
}

extension LoginViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
          print(error.localizedDescription)
          return
        }
        
        guard let accessToken = AccessToken.current?.tokenString else {
            showAlert(.facebookLoginFailed)
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
        
        Auth.auth().signIn(with: credential) { [weak self] user, error in
            if error != nil {
                self?.showAlert(.facebookLoginFailed)
                return
            }
            
            LoginManager.shared.saveFacebookLogin(accessToken: accessToken)
            self?.presentScheduleListView()
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        //TODO: Logout 구현
    }
}
