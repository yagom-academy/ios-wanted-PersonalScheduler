//
//  LoginViewController.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 06/01/23.
//

import UIKit

final class LoginViewController: UIViewController {

    private let calendarImageView: UIImageView = {
        let calendarImage = UIImage(named: "Calendar")
        let imageView = UIImageView(image: calendarImage)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private let loginView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.backgroundColor = .tertiary

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        drawView()
    }

    private func drawView() {
        view.backgroundColor = .primary
        configureHierarchy()
        configureLayout()
    }

    private func configureHierarchy() {
        view.addSubview(loginView)
        view.addSubview(calendarImageView)
    }

    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            calendarImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            calendarImageView.centerYAnchor.constraint(equalTo: safeArea.topAnchor,
                                                       constant: safeArea.layoutFrame.height/4),
            calendarImageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),

            loginView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            loginView.topAnchor.constraint(equalTo: calendarImageView.bottomAnchor, constant: 20),
            loginView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            loginView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier:  0.8),
        ])
    }
}
