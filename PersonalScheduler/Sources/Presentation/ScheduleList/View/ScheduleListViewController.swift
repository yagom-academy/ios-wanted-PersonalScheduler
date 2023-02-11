//
//  ScheduleListView.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import UIKit
import Combine

final class ScheduleListViewController: UIViewController {
    private let navigationBarView = NavigationBar(title: "스케쥴")
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가하기", for: .normal)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.setTitleColor(UIColor(named: "segmentSelectedColor"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    private let viewModel = ScheduleListViewModel(isLogged: true)
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bindAction()
        bind()
    }
}

private extension ScheduleListViewController {
    func bind() {
        viewModel.$isLogged
            .filter { $0 == false }
            .sink { [weak self] _ in
                self?.dismiss(animated: true)
            }
            .store(in: &cancellable)
    }
    
    func bindAction() {
//        logoutButton.tapPublisher
//            .sink { [weak self] _ in
//                self?.viewModel.logout()
//            }
//            .store(in: &cancellable)
    }
}

// MARK: - Configure UI
private extension ScheduleListViewController {
    func configureUI() {
        view.backgroundColor = .systemBackground
        addChildComponents()
        setUpLayout()
    }
    
    func addChildComponents() {
        [navigationBarView, addButton].forEach(view.addSubview)
    }
    
    func setUpLayout() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            navigationBarView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            navigationBarView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            navigationBarView.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBarView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.25),
            
            addButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            addButton.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.4),
            addButton.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor, constant: 28),
            
//            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

#if DEBUG
import SwiftUI

struct ServiceUnavailableViewPreview: PreviewProvider {
    static var previews: some View {
        ScheduleListViewController().showPreview()
            .edgesIgnoringSafeArea(.all)
    }
}
#endif

