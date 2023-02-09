//
//  LoginViewController.swift
//  PersonalScheduler
//
//  Created by junho lee on 2023/02/08.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FacebookLogin

final class LoginViewController: UIViewController {
    private let activityIndicatorView = UIActivityIndicatorView()
    private let titleLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .largeTitle))
    private let facebookLoginButton = {
        let button = FBLoginButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let stackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        titleLabel.text = Constants.title
        configureActivityIndicator()
        configureLoginButton()
        configureHierarchy()
        showListViewIfLoggedIn()
    }

    private func configureLoginButton() {
        facebookLoginButton.delegate = self
    }

    private func configureActivityIndicator() {
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .large
    }

    private func configureHierarchy() {
        stackView.addArrangedSubview(facebookLoginButton)
        view.addSubview(activityIndicatorView)
        view.addSubview(titleLabel)
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -50.0),

            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stackView.widthAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.widthAnchor,
                multiplier: Constants.stackViewWidthMultiplier
            ),
            stackView.heightAnchor.constraint(equalToConstant: Constants.stackViewHeight)
        ])
    }

    private func showListViewIfLoggedIn() {
        if Auth.auth().currentUser != nil {
            showListViewController()
        }
    }

    private func startLoadingAnimation() {
        DispatchQueue.main.async {
            self.activityIndicatorView.startAnimating()
            self.view.isUserInteractionEnabled = false
        }
    }

    private func stopLoadingAnimation() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
}

extension LoginViewController: LoginButtonDelegate {
    func loginButton(
        _ loginButton: FBSDKLoginKit.FBLoginButton,
        didCompleteWith result: FBSDKLoginKit.LoginManagerLoginResult?,
        error: Error?) {
            if let error {
                print(error.localizedDescription)
                stopLoadingAnimation()
                return
            }
            guard let tokenString = AccessToken.current?.tokenString else { return }
            let credential = FacebookAuthProvider.credential(withAccessToken: tokenString)
            firebaseLogin(credential)
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}

extension LoginViewController {
    private func firebaseLogin(_ credential: AuthCredential) {
        startLoadingAnimation()
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            guard let self else { return }
            if let error {
                let authError = error as NSError
                print(authError.localizedDescription)
                self.stopLoadingAnimation()
            }
            self.showListViewController()
        }
    }

    private func showListViewController() {
        DispatchQueue.main.async {
            let viewController = ListViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
            self.stopLoadingAnimation()
        }
    }
}

extension LoginViewController {
    private enum Constants {
        static let title = "Personal Scheduler"
        static let stackViewSpacing = 10.0
        static let stackViewWidthMultiplier = 0.9
        static let stackViewHeight = 44.0
    }
}
