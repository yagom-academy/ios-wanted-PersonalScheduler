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
    private var handle: AuthStateDidChangeListenerHandle?
    private var isMFAEnabled = false
    private let stackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10.0
        return stackView
    }()
    private let facebookLoginButton = {
        let button = FBLoginButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureHierarchy()
        configureLoginButton()
    }

    private func configureHierarchy() {
        stackView.addArrangedSubview(facebookLoginButton)
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }

    private func configureLoginButton() {
        facebookLoginButton.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { auth, user in
          // ...
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let handle else { return }
        Auth.auth().removeStateDidChangeListener(handle)
    }
}

extension LoginViewController: LoginButtonDelegate {
    func loginButton(
        _ loginButton: FBSDKLoginKit.FBLoginButton,
        didCompleteWith result: FBSDKLoginKit.LoginManagerLoginResult?,
        error: Error?) {
            if let error {
                print(error.localizedDescription)
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
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            guard let self else { return }
            if let error {
                let authError = error as NSError
                print(authError.localizedDescription)
            }
            self.showListViewController()
        }
    }

    private func showListViewController() {
        let viewController = ListViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
