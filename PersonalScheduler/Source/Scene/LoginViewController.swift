//
//  LoginViewController.swift
//  PersonalScheduler
//
//  Created by Kyo on 2023/02/07.
//

import UIKit

final class LoginViewController: UIViewController {
    private let viewModel: LoginViewModel
    private var fireStoreManager: FireStoreManager?
    
    private let loginImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstrinat()
    }
}

// MARK: - Button Action
extension LoginViewController {
    @objc private func kakaoLoginTapped() {
        viewModel.loginKakao { [weak self] nickName, email in
            guard let email = email else { return }
            
            // MARK: - TEST
            self?.fireStoreManager = FireStoreManager(user: nickName, email: email, social: .kakao)
            self?.fireStoreManager?.add(data: Schedule(id: UUID(), startDate: Date(), endDate: Date(), title: "테스트", content: "테스트컨텐츠"))
            
            self?.fireStoreManager?.load(completion: { schedules in
                print(schedules)
            })
        }
    }
}

extension LoginViewController {
    private func setupView() {
        view.backgroundColor = .systemBackground
        loginImageView.image = UIImage(named: "logo")
        kakaoLoginButton.setImage(UIImage(named: "kakao_login_image"), for: .normal)
        kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginTapped), for: .touchUpInside)
        
        [loginImageView, kakaoLoginButton].forEach(view.addSubview(_:))
    }
    
    private func setupConstrinat() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            loginImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 100),
            loginImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 30),
            loginImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -30),
            
            kakaoLoginButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            kakaoLoginButton.topAnchor.constraint(
                equalTo: loginImageView.bottomAnchor,
                constant: 50
            )
        ])
    }
}
