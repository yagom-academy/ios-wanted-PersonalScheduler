//  PersonalScheduler - LoginViewController.swift
//  Created by zhilly on 2023/02/07

import UIKit

final class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let viewModel: LoginViewModel
    
    // MARK: - Views
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Zhilly's Scheduler!"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let userInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
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
        setupAction()
    }
    
    // MARK: - Methods
    
    override func setupView() {
        super.setupView()
        [titleLabel, userInfoLabel, kakaoLoginButton, kakaoLogoutButton].forEach(view.addSubview(_:))
    }
    
    override func setupLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
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
    
    override func bindViewModel() {
        viewModel.userInfo.bind { [weak self] userInfo in
            self?.userInfoLabel.text = userInfo
        }
        
        viewModel.isLoginSuccess.bind { [weak self] isLoginSuccess in
            if isLoginSuccess {
                self?.presentScheduler()
            }
        }
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
    
    private func presentScheduler() {
        let viewModel = SchedulerViewModel()
        let schedulerViewController = SchedulerViewController(viewModel: viewModel,
                                                              userName: self.viewModel.userInfo.value ?? "")
        schedulerViewController.modalPresentationStyle = .fullScreen
        present(schedulerViewController, animated: true)
    }
}
