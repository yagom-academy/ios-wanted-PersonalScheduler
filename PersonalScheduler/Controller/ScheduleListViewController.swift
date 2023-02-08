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
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
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

// MARK: - UITableViewDataSource
extension ScheduleListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ScheduleModel.scheduleList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print(section)
        let dateText = ScheduleModel.scheduleList[section].date
        return createDateLabel(text: dateText)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let scheduleListCell = tableView.dequeueReusableCell(withIdentifier: ScheduleListCell.identifier, for: indexPath) as? ScheduleListCell else {
            return ScheduleListCell()
        }
        return scheduleListCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDelegate
extension ScheduleListViewController: UITableViewDelegate {

}

// MARK: - Objc Method
private extension ScheduleListViewController {
    @objc func touchUpCreateButton() {
        let detailScheduleViewController = DetailScheduleViewController()
        detailScheduleViewController.mode = .create
        navigationController?.pushViewController(detailScheduleViewController, animated: true)
    }
}

// MARK: - UIConfiguration
private extension ScheduleListViewController {
    func configureUI() {
        view.addSubview(tableView)
        settingNavigationBar()
        settingLayouts()
        settingTableView()
    }

    func settingLayouts() {
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func settingNavigationBar() {
        navigationItem.title = "스케쥴케어"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(touchUpCreateButton))
    }

    func settingTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ScheduleListCell.self, forCellReuseIdentifier: ScheduleListCell.identifier)
        tableView.contentInset.top = 20
        tableView.layoutIfNeeded()
    }

    func createDateLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = UIColor(hex: "#04CC00")
        return label
    }
}
