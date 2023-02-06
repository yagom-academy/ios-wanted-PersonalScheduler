//
//  MainViewController.swift
//  PersonalScheduler
//
//  Created by Dragon on 23/02/06.
//

import UIKit

class MainViewController: UIViewController {
    
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureLayout()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureLayout() {
        view.addSubview(loginView)
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            loginView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8),
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

