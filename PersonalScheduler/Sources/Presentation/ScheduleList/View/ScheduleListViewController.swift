//
//  ScheduleListView.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import UIKit
import Combine

final class ScheduleListViewController: UIViewController {
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그 아웃", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let viewModel = ScheduleListViewModel(isLogged: true)
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureUI()
        bind()
        
        // MARK: Logout
        let action = UIAction { _ in
            self.logout()
        }
        
        logoutButton.addAction(action, for: .touchUpInside)
    }
    
    private func logout() {
        viewModel.logout()
    }
}

private extension ScheduleListViewController {
    func bind() {
        viewModel.$isLogged
            .filter { $0 }
            .sink { [weak self] _ in
                self?.dismiss(animated: true)
            }
            .store(in: &cancellable)
    }
}

// MARK: - Configure UI
private extension ScheduleListViewController {
    func configureUI() {
        addChildComponents()
        setUpLayout()
    }
    
    func addChildComponents() {
        [logoutButton].forEach(view.addSubview)
    }
    
    func setUpLayout() {
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
