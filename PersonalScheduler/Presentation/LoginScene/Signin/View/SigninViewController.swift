//
//  SigninViewController.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/10.
//

import UIKit

final class SigninViewController: UIViewController {
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("등록하기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.backgroundColor = UIColor.systemGray3.cgColor
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let idTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addLeftPadding()
        textField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        textField.layer.cornerRadius = 5
        textField.placeholder = "이메일을 입력하세요"
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addLeftPadding()
        textField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        textField.layer.cornerRadius = 5
        textField.placeholder = "비밀번호를 입력하세요"
        return textField
    }()
    
    private let viewModel: SigninViewModel
    
    init(with viewModel: SigninViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        addSubviews()
        setupConstraints()
        setupButton()
    }
    
    private func setupInitialView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupButton() {
        registerButton.addTarget(
            self,
            action: #selector(registerButtonTapped),
            for: .touchUpInside
        )
    }
    
    private func retrieveInfo() -> LoginInfo? {
        guard let id = idTextField.text,
              let password = passwordTextField.text else { return nil }
        return LoginInfo(id: id, password: password)
    }
    
    @objc private func registerButtonTapped() {
        guard let loginInfo = retrieveInfo() else {
            return
        }
        do {
            try loginInfo.validate()
            successRegister(loginInfo)
        } catch let error as LoginError {
            AlertBuilder(
                title: "경고",
                message: error.description,
                preferredStyle: .alert
            ).setButton(name: "예", style: .default)
                .showAlert(on: self)
        } catch {
            print(String(describing: error))
        }
    }
    
    private func successRegister(_ loginInfo: LoginInfo) {
        Task {
            try await viewModel.registerButtonTapped(loginInfo) { email in
                AlertBuilder(
                    title: "알람",
                    message: "\(email) 등록 완료 !",
                    preferredStyle: .alert
                ).setButton(name: "확인", style: .default) {
                    _ = self.navigationController?.popViewController(animated: true)
                }.showAlert(on: self)
            }
        }
    }
}

private extension SigninViewController {
    
    func addSubviews() {
        view.addSubview(registerButton)
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            idTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            idTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -160),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
