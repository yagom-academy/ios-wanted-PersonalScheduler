//
//  ScheduleViewController.swift
//  PersonalScheduler
//
//  Created by 맹선아 on 2023/02/08.
//

import UIKit

final class ScheduleViewController: UIViewController {

    typealias DataSource = UITableViewDiffableDataSource<ScheduleSection, Event>
    typealias Snapshot = NSDiffableDataSourceSnapshot<ScheduleSection, Event>

    private let events: [Event] = [] // ViewModel로 리팩토링 예정
    private let scheduleTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    private var dataSource: DataSource? = nil
    private let snapshot: Snapshot = Snapshot()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureDateDataSource()
        applySnapshot()
    }

    private func configureDateDataSource() {
        registerCell()

        dataSource = DataSource(tableView: scheduleTableView) {tableView, indexPath, event in
            let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleCell.reuseIdentifier) as? ScheduleCell
            cell?.configureCell(with: ScheduleCellViewModel(event: event))

            return cell
        }
    }

    private func registerCell() {
        scheduleTableView.register(ScheduleCell.self, forCellReuseIdentifier: ScheduleCell.reuseIdentifier)
    }

    private func applySnapshot() {
        guard var snapshot = self.dataSource?.snapshot() else { return }
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        snapshot.appendItems(events)
        dataSource?.apply(snapshot)
    }

    private func configureHierarchy() {
        self.view.addSubview(scheduleTableView)
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            scheduleTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scheduleTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scheduleTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scheduleTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension ScheduleViewController {

    enum ScheduleSection {
        case main
    }
}
