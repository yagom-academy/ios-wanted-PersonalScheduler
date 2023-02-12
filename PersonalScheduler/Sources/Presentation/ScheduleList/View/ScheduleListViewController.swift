//
//  ScheduleListView.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import UIKit
import Combine

final class ScheduleListViewController: UIViewController {
    private let navigationBarView = ScheduleListTitleView(title: "스케쥴")
    
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
    
    private let scheduleListView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private var schedules: [Schedule] = []
    private let viewModel: ScheduleListViewModel
    private var cancellable = Set<AnyCancellable>()
    
    init(authService: FirebaseAuthService) {
        let listRepository = ScheduleListRepository(authService: authService)
        self.viewModel = ScheduleListViewModel(listRepository: listRepository)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        viewModel.$schedules
            .receive(on: DispatchQueue.main)
            .sink { values in
                self.schedules = values
            }
            .store(in: &cancellable)
    }
    
    func bindAction() {
        addButton.tapPublisher
            .sink { _ in
                let userRepository = ScheduleUserRepository(
                    authService: self.viewModel.firebaseAuthService,
                    dataBaseName: "Users"
                )
                let viewModel = ScheduleDetailViewModel(userRepository: userRepository)
                let controller = ScheduleDetailViewController(viewModel: viewModel)
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true)
            }
            .store(in: &cancellable)
        
//        logoutButton.tapPublisher
//            .sink { [weak self] _ in
//                self?.viewModel.logout()
//            }
//            .store(in: &cancellable)
    }
}

extension ScheduleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = schedules[indexPath.row].title
        
        return cell
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
