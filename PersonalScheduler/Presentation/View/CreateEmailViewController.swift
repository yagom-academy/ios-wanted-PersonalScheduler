//
//  EmailViewController.swift
//  PersonalScheduler
//
//  Created by 이예은 on 2023/01/09.
//

import UIKit
import FirebaseAuth

class CreateEmailViewController: UIViewController {
    private let logoVerticalStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .equalSpacing
        stackview.alignment = .center
        stackview.spacing = 10
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private let imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(systemName: "book.fill")
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.tintColor = .Red_60
        imageview.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageview.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return imageview
    }()
    
    private let introduceLabel: UILabel = {
        let label = UILabel()
        label.text = "Diary Schedular."
        label.font = UIFont(name: "NotoSansKannada-Bold", size: 30)
        label.numberOfLines = 2
        label.textAlignment = .natural
        label.textColor = .Red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let topVerticalStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        stackview.alignment = .fill
        stackview.spacing = 10
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private let emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.Red_60.cgColor
        textfield.text = "   email"
        textfield.font = UIFont(name: "NotoSansKannada-Regular", size: 15)
        textfield.layer.cornerRadius = 8
        textfield.backgroundColor = .Beige
        return textfield
    }()
    
    private let passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.text = "   password"
        textfield.font = UIFont(name: "NotoSansKannada-Regular", size: 15)
        textfield.layer.borderWidth = 1
        textfield.layer.cornerRadius = 8
        textfield.layer.borderColor = UIColor.Red_60.cgColor
        textfield.backgroundColor = .Beige
        return textfield
    }()
    
    private let saveAccountButton: UIButton = {
       let button = UIButton()
        button.setTitle("생성하기", for: .normal)
        button.backgroundColor = .Red_60
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "NotoSansKannada-Regular", size: 15)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 15
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setAutolayout()
        
        saveAccountButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }
    
    @objc func didTapSaveButton() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case 17007: // 이미 가입한 계정일 때
                    self.loginUser(withEmail: email, password: password)
                default:
                    print(error.localizedDescription)
                }
            } else {
                self.showMainViewController()
            }
        }
    }
    
    func showMainViewController() {
        let mainVC = MainViewController()
        self.show(mainVC, sender: nil)
    }
    
    func setup() {
        view.backgroundColor = .Beige
        view.addSubview(topVerticalStackView)
        view.addSubview(logoVerticalStackView)
        
        topVerticalStackView.addArrangedSubview(emailTextField)
        topVerticalStackView.addArrangedSubview(passwordTextField)
        topVerticalStackView.addArrangedSubview(saveAccountButton)
        
        logoVerticalStackView.addArrangedSubview(imageView)
        logoVerticalStackView.addArrangedSubview(introduceLabel)
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backButton.tintColor = .Red
        self.navigationItem.backBarButtonItem = backButton
    }
    
    func setAutolayout() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoVerticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 140),
            logoVerticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            logoVerticalStackView.heightAnchor.constraint(equalToConstant: 110),
            
            topVerticalStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 280),
            topVerticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            topVerticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    func loginUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self?.showMainViewController()
            }
        }
    }
}
