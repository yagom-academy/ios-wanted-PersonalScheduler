//
//  LoginView.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

import UIKit

final class LoginView: UIView {
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 40
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        return stackView
    }()
    
    private let titlesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private let HeaderTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.font = .boldSystemFont(ofSize: label.font.pointSize)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private let subTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    private let textFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private let idTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.addLeftPadding()
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.addLeftPadding()
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.backgroundColor = UIColor.systemGray5.cgColor
        button.layer.cornerRadius = 5
        return button
    }()
    
    let signInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("회원 가입", for: .normal)
        button.setTitleColor(.label, for: .normal)
        
        return button
    }()
    
    private let logoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
        return stackView
    }()
    
    private let fakeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(greaterThanOrEqualToConstant: 1).isActive = true
        view.heightAnchor.constraint(greaterThanOrEqualToConstant: 1).isActive = true
        view.setContentHuggingPriority(.init(100), for: .vertical)
        return view
    }()
    
    let kakaoLogoImageButton = LogoImageButton(
        width: 70,
        height: 70,
        image: UIImage(systemName: "photo")!
    )
    let facebookLogoImageButton = LogoImageButton(
        width: 70,
        height: 70,
        image: UIImage(systemName: "photo")!
    )
    let appleLogoImageButton = LogoImageButton(
        width: 70,
        height: 70,
        image: UIImage(systemName: "photo")!
    )
    private let labelSeparator = LabelSeparator(text: " SNS 계정 로그인 ")
    
    init() {
        super.init(frame: .zero)
        setupInitialView()
        addSubviews()
        setupLayer()
        setupData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialView() {
        backgroundColor = .systemBackground
    }
    
    private func setupData() {
        HeaderTitle.text = "Personal Schedular에 로그인 하세요."
        subTitle.text = "어느 기기에서든 나의 기록을 남길 수 있습니다."
        idTextField.placeholder = "아이디 입력"
        passwordTextField.placeholder = "비밀번호 입력"
    }
}

private extension LoginView {
    
    func addSubviews() {
        addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(titlesStackView)
        titlesStackView.addArrangedSubview(HeaderTitle)
        titlesStackView.addArrangedSubview(subTitle)
        
        mainStackView.addArrangedSubview(textFieldsStackView)
        textFieldsStackView.addArrangedSubview(idTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        
        mainStackView.addArrangedSubview(buttonStackView)
        buttonStackView.addArrangedSubview(loginButton)
        buttonStackView.addArrangedSubview(signInButton)
        
        mainStackView.addArrangedSubview(labelSeparator)
        
        mainStackView.addArrangedSubview(logoStackView)
        logoStackView.addArrangedSubview(kakaoLogoImageButton)
        logoStackView.addArrangedSubview(facebookLogoImageButton)
        logoStackView.addArrangedSubview(appleLogoImageButton) 
        mainStackView.addArrangedSubview(fakeView)
    }
    
    func setupLayer() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}
