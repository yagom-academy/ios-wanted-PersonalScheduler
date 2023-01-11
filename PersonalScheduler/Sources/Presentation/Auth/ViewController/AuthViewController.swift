//
//  ViewController.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit
import Combine
import AuthenticationServices

class AuthViewController: UIViewController {
    
    public weak var coordinator: AuthCoordinatorInterface?
    
    private let viewModel: AuthViewModel
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.input.viewWillAppear()
    }
    
    init(viewModel: AuthViewModel, coordinator: AuthCoordinatorInterface) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "개인 일정 관리"
        label.font = .preferredFont(for: .largeTitle, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "SNS 계정으로 간편 가입하기"
        label.font = .preferredFont(for: .callout, weight: .bold)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var loginButtonStackView: UIStackView = {
        let stackView = UIStackView(axis: .horizontal, alignment: .center, distribution: .fill, spacing: 16)
        stackView.addArrangedSubviews(kakaoButton, appleButton, facebookButton)
        return stackView
    }()
    
    private lazy var kakaoButton: LoginButton = {
        let button = LoginButton(image: UIImage(named: "kakao"))
        button.addTarget(self, action: #selector(didTapKakaoButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var appleButton: LoginButton = {
        let button = LoginButton(image: UIImage(named: "apple"))
        button.addTarget(self, action: #selector(didTapAppleButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var facebookButton: LoginButton = {
        let button = LoginButton(image: UIImage(named: "Facebook"))
        button.addTarget(self, action: #selector(didTapFacebookButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var helpButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인에 문제가 있나요?", for: .normal)
        button.titleLabel?.font = .preferredFont(for: .callout, weight: .bold)
        button.setTitleColor(.label.withAlphaComponent(0.8), for: .normal)
        button.addTarget(self, action: #selector(didTapHelpButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var activityIndicator: LoadingView = {
        let activityIndicator = LoadingView(backgroundColor: .clear, alpha: 1)
        return activityIndicator
    }()
    
}

private extension AuthViewController {
    
    func bind() {
        viewModel.output.isLoading
            .sinkOnMainThread(receiveValue: { [weak self] isLoading in
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }).store(in: &cancellables)
        
        viewModel.output.errorMessage
            .compactMap { $0 }
            .sinkOnMainThread(receiveValue: { [weak self] message in
                self?.showAlert(message: message)
            }).store(in: &cancellables)
        
        viewModel.output.isCompletedLogin
            .filter { $0 == true }
            .sinkOnMainThread(receiveValue: { [weak self] _ in
                self?.coordinator?.finished()
            }).store(in: &cancellables)
    }
    
    func setUp() {
        setUpLayout()
    }
    
    func setUpLayout() {
        view.backgroundColor = .psBackground
        view.addSubviews(titleLabel, loginButtonStackView, helpButton, descriptionLabel, activityIndicator)
        let deviceHeight = view.safeAreaLayoutGuide.layoutFrame.height
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -(deviceHeight * 0.178)),
            helpButton.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            helpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            loginButtonStackView.centerXAnchor.constraint(equalTo: helpButton.centerXAnchor),
            loginButtonStackView.bottomAnchor.constraint(equalTo: helpButton.topAnchor, constant: -110),
            descriptionLabel.centerXAnchor.constraint(equalTo: loginButtonStackView.centerXAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: loginButtonStackView.topAnchor, constant: -16),
            activityIndicator.widthAnchor.constraint(equalTo: view.widthAnchor),
            activityIndicator.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    @objc func didTapKakaoButton(_ sender: LoginButton) {
        viewModel.input.didTapKakaoButton()
    }
    
    @objc func didTapAppleButton(_ sender: LoginButton) {
        showAppleAuthorize()
        viewModel.input.didTapAppleButton()
    }
    
    func showAppleAuthorize() {
        let controller = viewModel.output.appleAuthorizationController
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    @objc func didTapFacebookButton(_ sender: LoginButton) {
        viewModel.input.didTapFacebookButton()
    }
    
    @objc func didTapHelpButton(_ sender: UIButton) {
        print(#function)
    }
    
}

extension AuthViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        view.window ?? UIWindow()
    }
}
