//  PersonalScheduler - LoginViewController.swift
//  Created by zhilly on 2023/02/07

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: LoginViewModel
    
    // MARK: - Views
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Zhilly's Scheduler!"
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let userInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "kakao_login_large_wide"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let kakaoLogoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Life Cycle
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupAction()
        bind()
    }
    
    // MARK: - Methods
    
    private func setupViews() {
        view.backgroundColor = .white
        
        let safeArea = view.safeAreaLayoutGuide
        
        [titleLabel, userInfoLabel, kakaoLoginButton, kakaoLogoutButton].forEach(view.addSubview(_:))
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 100),
            
            userInfoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userInfoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            
            kakaoLoginButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            kakaoLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            kakaoLoginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            kakaoLoginButton.heightAnchor.constraint(equalToConstant: 50),
            
            kakaoLogoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            kakaoLogoutButton.topAnchor.constraint(equalTo: kakaoLoginButton.bottomAnchor, constant: 16)
        ])
    }
    
    private func setupAction() {
        let kakaoLoginAction = UIAction { [weak self] _ in
            self?.viewModel.tappedKakaoLoginButton()
        }
        kakaoLoginButton.addAction(kakaoLoginAction, for: .touchUpInside)
        
        let kakaoLogoutAction = UIAction { [weak self] _ in
            self?.viewModel.kakaoLogout()
        }
        kakaoLogoutButton.addAction(kakaoLogoutAction, for: .touchUpInside)
    }
    
    private func bind() {
        viewModel.userInfo.bind { [weak self] userInfo in
            self?.userInfoLabel.text = userInfo
        }
    }
}
