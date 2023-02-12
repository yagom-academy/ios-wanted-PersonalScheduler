//
//  LoginViewController.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/06.
//

import UIKit

import FacebookLogin
import FirebaseAuth

class LoginViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "think, \nplan, \nand.. \nschedule it.\n\nPersonal Scheduler"
        label.font = UIFont(name: "Futura-MediumItalic", size: 35)
        label.numberOfLines = 6
        label.textAlignment = .left
        return label
    }()
    
    private let facebookLoginButton: LoginButton = {
        let loginButton = ButtonBuilder()
            .withProviderName("Facebook")
            .withTextColor(.white)
            .withLogoImage(UIImage(named: "facebook"))
            .withBackgroundColor(UIColor(red: 24/255, green: 119/255, blue: 242/255, alpha: 1))
            .build()
        return loginButton
    }()
    
    private let kakaoLoginButton: LoginButton = {
        let loginButton = ButtonBuilder()
            .withProviderName("Kakao")
            .withTextColor(.black)
            .withLogoImage(UIImage(named: "kakao"))
            .withBackgroundColor(UIColor(red: 254/255, green: 229/255, blue: 0, alpha: 1))
            .build()
        return loginButton
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 12
        return stackView
    }()
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureLayout()
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            totalStackView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.85),
            totalStackView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.85),
            totalStackView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            totalStackView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            
            facebookLoginButton.heightAnchor.constraint(equalToConstant: 60),
            kakaoLoginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        viewModel.delegate = self
        
        [facebookLoginButton, kakaoLoginButton].forEach(buttonStackView.addArrangedSubview(_:))
        [titleLabel, buttonStackView].forEach(totalStackView.addArrangedSubview(_:))
        view.addSubview(totalStackView)
        
        facebookLoginButton.addAction(UIAction(handler: tapFacebookLogin), for: .touchUpInside)
        kakaoLoginButton.addAction(UIAction(handler: tapKakaoLogin), for: .touchUpInside)
    }
    
    private func tapFacebookLogin(_ action: UIAction) {
        viewModel.action(.tapFacebookLogin)
    }
    
    private func tapKakaoLogin(_ action: UIAction) {
        viewModel.action(.tapKakaoLogin)
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func loginViewModel(successLogin uid: String) {
        let scheduleViewController = ViewControllerFactory.makeViewController(type: .schedule(userID: uid))
        
        present(scheduleViewController, animated: true)
    }
    
    func loginViewModel(failedLogin error: Error) {
        print(error.localizedDescription)
    }
    
    func loginViewModel(successLogout: Void) {
        
    }
    
    func loginViewModel(failedLogout error: Error) {
        print(error.localizedDescription)
    }
}
