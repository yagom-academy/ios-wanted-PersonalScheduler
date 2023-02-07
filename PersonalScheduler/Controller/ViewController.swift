//
//  ViewController.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Property
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "스케쥴케어"
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()

    private let kakaoLoginImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.image = UIImage(named: "kakao_login_medium_narrow")
        imageView.contentMode = .scaleAspectFill
//        imageView.sizeToFit()
        return imageView
    }()

    private let facebookLoginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor.init(hex: "#5B7CF2")
        return button
    }()

    private let appleLoginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor.init(hex: "#000000")
        return button
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureUI()
    }
}

private extension ViewController {
    func configureUI() {
        [titleLabel,
         kakaoLoginImageView,
         facebookLoginButton,
         appleLoginButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        settingLayouts()
    }

    func settingLayouts() {
        let smallSpacing: CGFloat = 20
        let buttonHeight: CGFloat = 60

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 4),

            kakaoLoginImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            kakaoLoginImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            kakaoLoginImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: view.frame.height / 4),

            facebookLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            facebookLoginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            facebookLoginButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            facebookLoginButton.topAnchor.constraint(equalTo: kakaoLoginImageView.bottomAnchor, constant: smallSpacing),

            appleLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appleLoginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            appleLoginButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            appleLoginButton.topAnchor.constraint(equalTo: facebookLoginButton.bottomAnchor, constant: smallSpacing)

        ])
    }
}
