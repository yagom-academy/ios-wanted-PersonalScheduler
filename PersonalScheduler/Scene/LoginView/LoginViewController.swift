//
//  LoginViewController.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/06.
//

import UIKit

import FacebookLogin

class LoginViewController: UIViewController {
    private let facebookLoginButton: FBLoginButton = {
        let button = FBLoginButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureView()
        configureLayout()
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            facebookLoginButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            facebookLoginButton.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
        ])
    }
    
    private func configureView() {
        view.addSubview(facebookLoginButton)
    }
}
