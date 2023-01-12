//
//  LoginViewController.swift
//  PersonalScheduler
//
//  Created by Judy on 2023/01/12.
//

import UIKit
import KakaoSDKUser
import FacebookLogin

final class LoginViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.font = .boldSystemFont(ofSize: label.font.pointSize)
        label.textColor = .label
        label.textAlignment = .center
        label.text = "일정 관리 시작하기"
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.text = "한 번 로그인하면 이후 자동 로그인 됩니다."
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "kakao_login_large_narrow"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addLoginButtonTarget()
        addNotification()
    }
    
    private func setupView() {
        let loginButton = FBLoginButton()
        let spacingView = UIView()
        spacingView.translatesAutoresizingMaskIntoConstraints = false
    
        loginStackView.addArrangedSubview(titleLabel)
        loginStackView.addArrangedSubview(infoLabel)
        loginStackView.addArrangedSubview(spacingView)
        loginStackView.addArrangedSubview(loginButton)
        loginStackView.addArrangedSubview(kakaoLoginButton)
        
        view.addSubview(loginStackView)
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            loginStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                    constant: 16),
            loginStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                     constant: -16),
            loginStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
    
            spacingView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor,
                                                multiplier: 1/4),
        ])
    }
    
    private func addNotification() {
        NotificationCenter.default.addObserver(forName: .AccessTokenDidChange,
                                               object: nil,
                                               queue: OperationQueue.main,
                                               using: facebookButtonTapped)
    }
    
    private func addLoginButtonTarget() {
        kakaoLoginButton.addTarget(self,
                                   action: #selector(kakaoLoginButtonTapped),
                                   for: .touchUpInside)
    }
    
    @objc private func kakaoLoginButtonTapped() {
        guard UserApi.isKakaoTalkLoginAvailable() == true else { return }
        
        UserApi.shared.loginWithKakaoAccount { [weak self] oauthToken, error in
            if let error = error {
                self?.showAlert(message: "카카오 로그인에 실패했습니다.\n\(error.localizedDescription)")
            } else {
                if let token = oauthToken?.accessToken {
                    self?.presentScheduleListView(with: token)
                }
            }
        }
    }
    
    private func presentScheduleListView(with token: String) {
        let scheduleViewModel = ScheduleViewModel(with: token)
        let scheduleListView = ScheduleListViewController(scheduleViewModel)
        let navigationController = UINavigationController(rootViewController: scheduleListView)
        
        LoginManager.shared.saveUserToken(token)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    @objc private func facebookButtonTapped(_ notification: Notification) {
        if let token = AccessToken.current?.tokenString {
            presentScheduleListView(with: token)
        }
    }
}
