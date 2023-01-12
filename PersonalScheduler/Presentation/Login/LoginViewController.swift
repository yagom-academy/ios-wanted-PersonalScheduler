//
//  ViewController.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit
import AuthenticationServices

// MARK: - Life Cycle

final class LoginViewController: UIViewController {

    private let viewModel: LoginViewModel!
    
    init(viewModel: LoginViewModel = LoginViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = LoginViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Attributes

extension LoginViewController {
    
}

// MARK: - Actions

extension LoginViewController {
    
}

// MARK: - Bind

extension LoginViewController {
 
    private func bind() {
        
    }
}

// MARK: - Constraints

extension LoginViewController {
    
}

