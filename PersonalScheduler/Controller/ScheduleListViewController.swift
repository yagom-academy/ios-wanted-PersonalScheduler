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
        tableView.backgroundColor = .systemBackground
        return tableView
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureUI()
        fetchScheduleList()
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
        let dateText = ScheduleModel.scheduleList[section].date
        return createDateLabel(text: dateText)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentDate = DateformatterManager.shared.convertDateToString(date: Date())
        guard let scheduleListCell: ScheduleListCell = tableView.dequeueReusableCell(withIdentifier: ScheduleListCell.identifier, for: indexPath) as? ScheduleListCell,
              let goalDate = DateformatterManager.shared.convertStringToDate(dateText: ScheduleModel.scheduleList[indexPath.section].date),
              let currentDate = DateformatterManager.shared.convertStringToDate(dateText: currentDate) else {
            return ScheduleListCell()
        }
        scheduleListCell.configureCell(data: ScheduleModel.scheduleList[indexPath.section])

        switch currentDate.compare(goalDate) {
        case .orderedAscending, .orderedSame:
            scheduleListCell.layer.borderColor = UIColor(hex: "#04CC00").cgColor
        case .orderedDescending:
            scheduleListCell.layer.borderColor = UIColor(hex: "9E9E9E").cgColor
        }
        return scheduleListCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDelegate
extension ScheduleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moveToDetailScheduleViewController(indexPath)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let updateAction = swipeUpdateAction(indexPath)
        let deleteAction = swipeDeleteAction(indexPath)
        return UISwipeActionsConfiguration(actions: [deleteAction, updateAction])
    }
}

// MARK: - DetailViewDelegate
extension ScheduleListViewController: DetailScheduleDelegate {
    func createSchedule(data: ScheduleModel) {
        ScheduleModel.scheduleList.append(data)
        sortScheduleList()
    }

    func updateSchedule(data: ScheduleModel) {
        guard let index = ScheduleModel.scheduleList.firstIndex(where: { scheduleModel in
            scheduleModel.id == data.id
        }) else { return }

        ScheduleModel.scheduleList[index] = data
        sortScheduleList()
    }
}

// MARK: - Method
private extension ScheduleListViewController {
    func fetchScheduleList() {
        FirebaseManager.shared.fetchAllScheduleData { [weak self] data in
            ScheduleModel.scheduleList = data
            self?.sortScheduleList()
        }
    }

    func sortScheduleList() {
        ScheduleModel.scheduleList = ScheduleModel.scheduleList.sorted(by: {
            DateformatterManager.shared.convertStringToDate(dateText: $0.date)?.compare(DateformatterManager.shared.convertStringToDate(dateText: $1.date) ?? Date()) == .orderedDescending
        })
        tableView.reloadData()
    }

    func moveToDetailScheduleViewController(_ indexPath: IndexPath) {
        let detailScheduleViewController = DetailScheduleViewController()
        detailScheduleViewController.mode = .update
        detailScheduleViewController.modelID = ScheduleModel.scheduleList[indexPath.section].id
        detailScheduleViewController.detailScheduleDelegate = self
        navigationController?.pushViewController(detailScheduleViewController, animated: true)
    }

    func swipeUpdateAction(_ indexPath: IndexPath) -> UIContextualAction {
        let updateAction = UIContextualAction(style: .normal, title: "Update") { [weak self] _, _, handler in
            self?.moveToDetailScheduleViewController(indexPath)
            handler(true)
        }
        return updateAction
    }

    func swipeDeleteAction(_ indexPath: IndexPath) -> UIContextualAction {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, handler in
            ScheduleModel.scheduleList.remove(at: indexPath.section)
            self?.tableView.reloadData()
            handler(true)
        }
        return deleteAction
    }
}

// MARK: - Objc Method
private extension ScheduleListViewController {
    @objc func touchUpCreateButton() {
        let detailScheduleViewController = DetailScheduleViewController()
        detailScheduleViewController.mode = .create
        detailScheduleViewController.detailScheduleDelegate = self
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
        sortScheduleList()
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

    func createDateLabel(text: String) -> UILabel? {
        let label = UILabel()
        guard let goalDate = DateformatterManager.shared.convertStringToDate(dateText: text) else {
            return nil
        }
        let currentDate = DateformatterManager.shared.convertDateToString(date: Date())
        guard let currentDate = DateformatterManager.shared.convertStringToDate(dateText: currentDate) else { return nil }

        switch currentDate.compare(goalDate) {
        case .orderedAscending, .orderedSame:
            label.textColor = UIColor(hex: "#04CC00")
        case .orderedDescending:
            label.textColor = UIColor(hex: "9E9E9E")
        }
        label.text = text
        return label
    }
}
