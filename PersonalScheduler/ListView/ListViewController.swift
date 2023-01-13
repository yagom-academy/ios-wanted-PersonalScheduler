//
//  ListViewController.swift
//  PersonalScheduler
//
//  Created by unchain on 2023/01/11.
//

import UIKit
import Combine

class ListViewController: UIViewController {
    private let listViewModel = ListViewModel()
    private var cancelable = Set<AnyCancellable>()

    private let scheduleTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: ScheduleTableViewCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "할일 목록"
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()

    private lazy var addScheduleButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "plus")
        button.target = self
        button.action = #selector(tappedAddButton)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = scheduleTableView
        self.view.backgroundColor = .white
        self.navigationItem.titleView = titleLabel
        self.navigationItem.rightBarButtonItem = addScheduleButton
        setTableView()
        bind()
        self.scheduleTableView.reloadData()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.scheduleTableView.reloadData()
        listViewModel.input.onViewWillAppear()
    }

    private func setTableView() {
        self.scheduleTableView.delegate = self
        self.scheduleTableView.dataSource = self
    }
}

//MARK: Extension
extension ListViewController {
    private func bind() {
        listViewModel.scheduleAddPublisher
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.navigationController?.pushViewController(ScheduleAddViewController(scheduleAddViewModel: nil, isEditing: false), animated: true)
            }
            .store(in: &cancelable)

        listViewModel.output.tableViewReloadPublisher
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.scheduleTableView.reloadData()
            }
            .store(in: &cancelable)

        listViewModel.output.didSelectCellPublisher
            .sink { [weak self] schedules in
                guard let self = self else { return }
                self.navigationController?.pushViewController(ScheduleAddViewController(scheduleAddViewModel: ScheduleAddViewModel(readSchedule: schedules), isEditing: true), animated: true)
            }
            .store(in: &cancelable)
    }

    @objc private func tappedAddButton() {
        listViewModel.input.tappedAddButton()
    }
}


//MARK: UITableViewDelegate, UITableViewDataSource
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.schedules.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.identifier,
                                                       for: indexPath) as? ScheduleTableViewCell else { return ScheduleTableViewCell() }
        cell.configureCell(at: indexPath, cellData: listViewModel.schedules)
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in

            self.listViewModel.input.deleteButtonDidTap(user: "user", indexPath: indexPath)
            self.scheduleTableView.reloadData()
        }
        delete.backgroundColor = .systemRed

        return UISwipeActionsConfiguration(actions: [delete])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listViewModel.input.didSelectCell(indexPath: indexPath)
    }
}
