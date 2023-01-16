//
//  ViewController.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit

class LoginViewController: UIViewController {
    private let topVerticalStackView: UIStackView = {
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
        label.text = "Diary Schedular"
        label.font = UIFont(name: "NotoSansKannada-Bold", size: 30)
        label.numberOfLines = 2
        label.textAlignment = .natural
        label.textColor = .Red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bottomVerticalStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .equalSpacing
        stackview.alignment = .fill
        stackview.spacing = 10
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private let emailLoginButton: UIButton = {
       let button = UIButton()
        button.setTitle("email/password login", for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKannada-Regular", size: 20)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.Red_60.cgColor
        button.layer.cornerRadius = 15
        return button
    }()
    
    private let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("kakao login", for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKannada-Regular", size: 20)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.Red_60.cgColor
        button.layer.cornerRadius = 15
        return button
    }()
    
    private let appleLoginButton: UIButton = {
       let button = UIButton()
        button.setTitle(" facebook login ", for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKannada-Regular", size: 20)
        button.setTitleColor(.black, for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.Red_60.cgColor
        button.layer.cornerRadius = 15
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setAutolayout()
        
        emailLoginButton.addTarget(self, action: #selector(didTapEmailLoginButton), for: .touchUpInside)
        kakaoLoginButton.addTarget(self, action: #selector(didTapKakaoLoginButton), for: .touchUpInside)
        appleLoginButton.addTarget(self, action: #selector(didTapAppleLoginButton), for: .touchUpInside)
    }
    
    @objc func didTapEmailLoginButton() {
        let emailVC = CreateEmailViewController()
        navigationController?.pushViewController(emailVC, animated: true)
    }
    
    @objc func didTapKakaoLoginButton() {
        let kakaoVC = KakaoLoginViewController()
        navigationController?.pushViewController(kakaoVC, animated: true)
    }
    
    @objc func didTapAppleLoginButton() {
        let facebookVC = FacebookLoginViewController()
        navigationController?.pushViewController(facebookVC, animated: true)
    }
    
    func setup() {
        view.backgroundColor = UIColor.Beige
        view.addSubview(topVerticalStackView)
        view.addSubview(bottomVerticalStackView)
        
        topVerticalStackView.addArrangedSubview(imageView)
        topVerticalStackView.addArrangedSubview(introduceLabel)
        
        bottomVerticalStackView.addArrangedSubview(emailLoginButton)
        bottomVerticalStackView.addArrangedSubview(kakaoLoginButton)
        bottomVerticalStackView.addArrangedSubview(appleLoginButton)
    }
    
    func setAutolayout() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topVerticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 140),
            topVerticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            topVerticalStackView.heightAnchor.constraint(equalToConstant: 110),
            
            bottomVerticalStackView.topAnchor.constraint(equalTo: topVerticalStackView.bottomAnchor, constant: 200),
            bottomVerticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bottomVerticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}

