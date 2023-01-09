//
//  LoginView.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

import UIKit

final class LoginView: UIView {
    let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupInitialView()
        addSubviews()
        setupLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInitialView() {
        backgroundColor = .systemBackground
    }
}

private extension LoginView {
    
    func addSubviews() {
        addSubview(loginButton)
    }
    
    func setupLayer() {
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
