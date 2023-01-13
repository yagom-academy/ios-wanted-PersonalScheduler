//
//  SignViewController.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/11.
//
import UIKit
import AuthenticationServices

final class SignViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let viewModel: SignViewModel
    
    // MARK: - Views
    
    private let mainTitle: UILabel = {
        let label = UILabel()
        label.text = "제리네 스케줄러"
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subTitle: UILabel = {
        let label = UILabel()
        label.text = "일정을 관리해보세요!"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let kakaoButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(named: "kakao.color")
        button.setTitleColor(.black, for: .normal)
        button.setTitle("카카오 로그인", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let appleButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Apple 로그인", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Life Cycle
    
    init() {
        self.viewModel = SignViewModel()
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    
    override func setupView() {
        view.backgroundColor = .systemBackground
        
        kakaoButton.addTarget(self, action: #selector(didTapKakaoLoginButton), for: .touchUpInside)
        appleButton.addTarget(self, action: #selector(didTapAppleLoginButton), for: .touchUpInside)
    }
    
    override func addView() {
        [mainTitle, subTitle, kakaoButton, appleButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300),
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subTitle.topAnchor.constraint(equalTo: self.mainTitle.bottomAnchor, constant: 20),
            subTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            kakaoButton.topAnchor.constraint(equalTo: subTitle.bottomAnchor,
                                             constant: UIScreen.main.bounds.size.height / 6),
            kakaoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            kakaoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            kakaoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            kakaoButton.heightAnchor.constraint(equalToConstant: 44),
            
            appleButton.topAnchor.constraint(equalTo: kakaoButton.bottomAnchor, constant: 8),
            appleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            appleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            appleButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    override func bindViewModel() {
        
        // Output
        
        viewModel.goToListScene.subscribe() { [weak self] isAvailable in
            guard let isAvailable = isAvailable else { return }
            if isAvailable {
                self?.goToListScene()
            }
        }
    }
    
}

private extension SignViewController {
    
    @objc func didTapKakaoLoginButton() {
        viewModel.didTapKakaoLoginButton()
    }
    
    @objc func didTapAppleLoginButton() {
        viewModel.didTapAppleLoginButton()
        setupAppleLogin()
    }
    
    func setupAppleLogin() {
        let authorizationController = viewModel.getAppleAuthorizationController()
        authorizationController.presentationContextProvider = self
    }
    
    func goToListScene() {
        DispatchQueue.main.async {
            let scheduleListViewController = ScheduleListViewController()
            scheduleListViewController.navigationItem.hidesBackButton = true
            self.navigationController?.pushViewController(scheduleListViewController, animated: true)
        }
    }
    
}

extension SignViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        self.view.window!
    }
}
