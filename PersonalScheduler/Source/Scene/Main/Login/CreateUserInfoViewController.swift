//
//  CreateUserInfoViewController.swift
//  PersonalScheduler
//
//  Created by yonggeun Kim on 2023/02/08.
//

import UIKit

class CreateUserInfoViewController: UIViewController {
    
    private let normalLoginView = NormalLoginView(frame: .zero, mode: .create)
    private let createGuideLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "회원가입"
        label.font = .preferredFont(forTextStyle: .headline).withSize(25)
        label.textColor = .label
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureLayout()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureLayout() {
        normalLoginView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(createGuideLabel)
        view.addSubview(normalLoginView)
        
        NSLayoutConstraint.activate([
            createGuideLabel.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: view.frame.height * 0.1
            ),
            createGuideLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            normalLoginView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            normalLoginView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.255),
            normalLoginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            normalLoginView.topAnchor.constraint(
                equalTo: createGuideLabel.bottomAnchor,
                constant: view.frame.height * 0.1
            ),
        ])
    }
}
