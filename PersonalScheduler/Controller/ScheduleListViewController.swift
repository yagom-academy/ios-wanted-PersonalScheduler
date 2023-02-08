//
//  ScheduleListViewController.swift
//  PersonalScheduler
//
//  Created by Mangdi on 2023/02/08.
//

import UIKit

final class ScheduleListViewController: UIViewController {

    // MARK: - Property
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureUI()
    }
}

// MARK: - UIConfiguration
private extension ScheduleListViewController {
    func configureUI() {
        view.addSubview(tableView)
        settingNavigationBar()
        settingLayouts()
    }

    func settingLayouts() {
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }

    func settingNavigationBar() {
        navigationItem.title = "스케쥴케어"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
    }
}
