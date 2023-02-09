//
//  CreateUserInfoViewController.swift
//  PersonalScheduler
//
//  Created by yonggeun Kim on 2023/02/08.
//

import UIKit
import FirebaseAuth
import FirebaseCore

final class CreateUserInfoViewController: UIViewController {
    
    // MARK: Private Properties
    
    private let normalLoginView = NormalLoginView(frame: .zero, mode: .create)
    private let indicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.color = .orange
        activityIndicatorView.style = .large
        activityIndicatorView.stopAnimating()
        return activityIndicatorView
    }()
    private let createLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "회원가입"
        label.font = .preferredFont(forTextStyle: .headline).withSize(25)
        label.textColor = .label
        return label
    }()
    private let createIdGuideLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "[ID] E-Mail 형식으로 입력하세요. (최대 20자)"
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    private let createPwGuideLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "[PW] 최소 6자리 이상 입력하세요. (최대 20자)"
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureLayout()
        configureDelegate()
    }
    
    // MARK: Private Methods
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureDelegate() {
        normalLoginView.delegate = self
    }
    
    private func createUserInfo(email: String, password: String) {
        indicatorView.startAnimating()
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error)
            } else {
                self.navigationController?.popViewController(animated: true)
                self.indicatorView.stopAnimating()
            }
        }
    }
    
    private func configureLayout() {
        normalLoginView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(createLabel)
        view.addSubview(normalLoginView)
        view.addSubview(createIdGuideLabel)
        view.addSubview(createPwGuideLabel)
        view.addSubview(indicatorView)
        
        indicatorView.center = view.center
        
        NSLayoutConstraint.activate([
            createLabel.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: view.frame.height * 0.13
            ),
            createLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            normalLoginView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            normalLoginView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.255),
            normalLoginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            normalLoginView.topAnchor.constraint(
                equalTo: createLabel.bottomAnchor,
                constant: view.frame.height * 0.07
            ),
            
            createIdGuideLabel.topAnchor.constraint(equalTo: normalLoginView.bottomAnchor, constant: 20),
            createIdGuideLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createPwGuideLabel.topAnchor.constraint(equalTo: createIdGuideLabel.bottomAnchor, constant: 10),
            createPwGuideLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

// MARK: - UserInfoSendable

extension CreateUserInfoViewController: UserInfoSendable {
    func sendUserInfo(id: String, password: String) {
        createUserInfo(email: id, password: password)
    }
    
    func presentCreateUserInfoView() {}
}
