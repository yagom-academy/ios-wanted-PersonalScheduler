//
//  ViewController.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit
import FacebookLogin

class MainViewController: UIViewController {
    
    static func instance() -> MainViewController {
        let viewModel = MainViewModel()
        let viewController = MainViewController(mainViewModel: viewModel)
        return viewController
    }
    
    private enum Constant {
        static var kakaoButton = "kakao_button_large"
        static var faceBookButton = ""
    }

    private var mainViewModel: MainViewModelable
    
    init(mainViewModel: MainViewModelable) {
        self.mainViewModel = mainViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        mainViewModel.viewDidLoad()
        setupView()
    }
    
    private func bind() {
        mainViewModel.userId.observe(on: self) { [weak self] userId in
            guard let userId = userId else {
                return
            }
            let viewController = ListViewController.instance(userId: userId)
            viewController.modalPresentationStyle = .fullScreen
            self?.present(viewController, animated: true)
        }
        
        mainViewModel.errorMessage.observe(on: self) { [weak self] errorMessage in
            guard let errorMessage = errorMessage else {
                return
            }
            self?.showErrorAlert(message: errorMessage)
        }
    }
    
    // MARK - View
    
    private lazy var AppTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .title1)
        label.numberOfLines = 2
        label.text = """
                    PersonalScheduler
                    개인 스케줄 관리앱
                    """
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
    private lazy var kakaoButton: UIButton = {
        let button = UIButton(frame: .zero)
        let image = UIImage(named: Constant.kakaoButton)
        
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(kakoLogin(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var facebookButton: UIButton = {
        let button = FBLoginButton()
        button.delegate = self
        return button
    }()
    
    @objc func kakoLogin(_ sender: UIButton) {
        mainViewModel.login(loginType: .kakao)
    }
    
    @objc func faceBookLogin(_ sender: UIButton) {
        mainViewModel.login(loginType: .facebook)
    }
    
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubviews(AppTitle, kakaoButton, facebookButton)
        NSLayoutConstraint.activate([
            AppTitle.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -100),
            AppTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            AppTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            kakaoButton.topAnchor.constraint(equalTo: AppTitle.bottomAnchor, constant: 150),
            kakaoButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            kakaoButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            kakaoButton.heightAnchor.constraint(equalTo: kakaoButton.widthAnchor, multiplier: 0.2)
        ])
        
        NSLayoutConstraint.activate([
            facebookButton.topAnchor.constraint(equalTo: kakaoButton.bottomAnchor, constant: 20),
            facebookButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            facebookButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            facebookButton.heightAnchor.constraint(equalTo: kakaoButton.widthAnchor, multiplier: 0.2)
        ])
    }
}

extension MainViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let _ = result {
            mainViewModel.login(loginType: .facebook)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        return
    }
}
