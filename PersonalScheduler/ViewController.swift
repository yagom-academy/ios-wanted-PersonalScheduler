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
        label.text = "asdf"
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()

    private let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        return button
    }()

    private let facebookLoginButton: UIButton = {
        let button = UIButton()
        return button
    }()

    private let appleLoginButton: UIButton = {
        let button = UIButton()
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
         kakaoLoginButton,
         facebookLoginButton,
         appleLoginButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        settingLayouts()
    }

    func settingLayouts() {
        let smallSpacing: CGFloat = 20

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 4),

            kakaoLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            kakaoLoginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            kakaoLoginButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: view.frame.height / 4),

            facebookLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            facebookLoginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            facebookLoginButton.topAnchor.constraint(equalTo: kakaoLoginButton.bottomAnchor, constant: smallSpacing),

            appleLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appleLoginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            appleLoginButton.topAnchor.constraint(equalTo: facebookLoginButton.bottomAnchor, constant: smallSpacing)

        ])
    }
}
