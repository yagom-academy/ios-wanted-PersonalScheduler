//
//  NormalLoginView.swift
//  PersonalScheduler
//
//  Created by Dragon on 2023/02/08.
//

import UIKit

class NormalLoginView: UIView {
    
    var delegate: UserInfoSendable?
    private var loginMode: LoginMode = .login
    private let idLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.text = "ID :"
        label.textAlignment = .right
        label.textColor = .label
        return label
    }()
    private let idTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.layer.borderColor = UIColor.label.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.text = "PW :"
        label.textAlignment = .right
        label.textColor = .label
        return label
    }()
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textField.textAlignment = .left
        textField.layer.borderColor = UIColor.label.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    private let leftButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .label
        return button
    }()
    private let rightButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .label
        return button
    }()
    private let idStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    private let passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        return stackView
    }()
    
    
    init(frame: CGRect, mode: LoginMode) {
        super.init(frame: frame)
        
        self.loginMode = mode
        
        configureLayout()
        configureNormalLoginButtonAction(loginMode)
        configureButtonText(loginMode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureNormalLoginButtonAction(_ mode: LoginMode) {
        switch mode {
        case .create:
            leftButton.addTarget(self, action: #selector(tapCreateLeftButton), for: .touchDown)
            rightButton.addTarget(self, action: #selector(tapCreateRightButton), for: .touchDown)
        case .login:
            leftButton.addTarget(self, action: #selector(tapLoginLeftButton), for: .touchDown)
            rightButton.addTarget(self, action: #selector(tapLoginRightButton), for: .touchDown)
        }
    }
    
    func configureButtonText(_ mode: LoginMode) {
        switch mode {
        case .login:
            leftButton.setTitle("로그인", for: .normal)
            rightButton.setTitle("회원가입", for: .normal)
        case .create:
            leftButton.setTitle("생성", for: .normal)
            rightButton.setTitle("초기화", for: .normal)
        }
    }
    
    private func setUpStackView() {
        idStackView.addArrangedSubview(idLabel)
        idStackView.addArrangedSubview(idTextField)
        
        passwordStackView.addArrangedSubview(passwordLabel)
        passwordStackView.addArrangedSubview(passwordTextField)
        
        buttonStackView.addArrangedSubview(leftButton)
        buttonStackView.addArrangedSubview(rightButton)
        
        infoStackView.addArrangedSubview(idStackView)
        infoStackView.addArrangedSubview(passwordStackView)
    }
    
    private func configureLayout() {
        setUpStackView()
        
        addSubview(infoStackView)
        addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            idLabel.widthAnchor.constraint(equalTo: idStackView.widthAnchor, multiplier: 0.2),
            idStackView.widthAnchor.constraint(equalTo: infoStackView.widthAnchor, multiplier: 0.85),
            
            passwordLabel.widthAnchor.constraint(equalTo: passwordStackView.widthAnchor, multiplier: 0.2),
            passwordStackView.widthAnchor.constraint(equalTo: infoStackView.widthAnchor, multiplier: 0.85),
            
            
            infoStackView.widthAnchor.constraint(equalTo: widthAnchor),
            infoStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            infoStackView.topAnchor.constraint(equalTo: topAnchor),
            
            buttonStackView.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 30),
            buttonStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            buttonStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            buttonStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    @objc
    private func tapLoginLeftButton() {
        if let userID = idTextField.text,
           let userPW = passwordTextField.text {
            delegate?.signInUserInfo(id: userID, password: userPW)
        }
    }
    
    @objc
    private func tapCreateLeftButton() {
        if let userID = idTextField.text,
           let userPW = passwordTextField.text {
            delegate?.createUserInfo(id: userID, password: userPW)
        }
    }
    
    @objc
    private func tapLoginRightButton() {
        delegate?.presentCreateUserInfoView()
    }
    
    @objc
    private func tapCreateRightButton() {
        idTextField.text = String()
        passwordTextField.text = String()
    }
}
