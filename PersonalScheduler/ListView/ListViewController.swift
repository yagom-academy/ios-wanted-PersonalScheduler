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
                self.navigationController?.pushViewController(ScheduleAddViewController(), animated: true)
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
}
