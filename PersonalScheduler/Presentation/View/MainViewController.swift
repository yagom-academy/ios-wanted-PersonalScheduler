//
//  MainViewController.swift
//  PersonalScheduler
//
//  Created by 이예은 on 2023/01/09.
//

import UIKit
import FirebaseAuth
import Combine

class MainViewController: UIViewController {
    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = UIColor(r: 61, g: 64, b: 91)
        let email  = Auth.auth().currentUser?.email ?? "고객"
        label.text = "환영합니다 \(email)님!"
        label.font = UIFont(name: "NotoSansKannada-Bold", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let topVerticalStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .equalSpacing
        stackview.alignment = .fill
        stackview.spacing = 10
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.Red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.Red.cgColor
        button.layer.cornerRadius = 15
        button.setTitle("로그아웃", for: .normal)
        return button
    }()

    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.Red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.Red.cgColor
        button.layer.cornerRadius = 15
        button.setTitle("스케줄로 넘어가기", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setAutolayout()
        
        logoutButton.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }
    
    func setup() {
        view.backgroundColor = .Beige
        view.addSubview(topVerticalStackView)
        view.addSubview(greetingLabel)
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backButton.tintColor = .Red
        self.navigationItem.backBarButtonItem = backButton
        
        topVerticalStackView.addArrangedSubview(logoutButton)
        topVerticalStackView.addArrangedSubview(nextButton)
    }
    
    func setAutolayout() {
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 280),
            greetingLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            greetingLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            greetingLabel.heightAnchor.constraint(equalToConstant: 100),
            
            topVerticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topVerticalStackView.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 200),
            topVerticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            topVerticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func didTapLogoutButton() {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            
            let loginVC = LoginViewController()
            self.show(loginVC, sender: nil)
        } catch let signoutError as NSError {
            print(signoutError.localizedDescription)
        }
    }
    
    @objc func didTapNextButton() {
        guard let user = Auth.auth().currentUser,
              let userEmail = user.email else {
            return
        }
        
        let schedularVC = SchedularViewController(viewModel: ScheduleViewModel(email: userEmail))
        
        self.navigationController?.pushViewController(schedularVC, animated: true)
        
    }
}
