//
//  ScheduleViewController.swift
//  PersonalScheduler
//
//  Created by bard on 2023/01/11.
//

import UIKit

final class ScheduleViewController: UIViewController, ScheduleDelegate {
    
    // MARK: Properties
    
    private var scheduleList: [Schedule] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    func appendSchedule(_ schedule: Schedule) {
        scheduleList.append(schedule)
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Personal\nScheduler"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.numberOfLines = 2
        
        return label
    }()
    
    private let enrollButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            ScheduleCell.self,
            forCellReuseIdentifier: ScheduleCell.identifier
        )
        
        return tableView
    }()
    
    // MARK: - Initializers
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    // MARK: - Methods
    
    private func commonInit() {
        modalPresentationStyle = .fullScreen
        view.backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
        setupTableView()
        setupEnrollButton()
    }
    
    private func setupSubviews() {
        [titleLabel, enrollButton, tableView]
            .forEach { view.addSubview($0) }
    }
    
    private func setupConstraints() {
        setupTitleLabelConstraints()
        setupTableViewContraints()
        setupEnrollButtonConstraints()
    }
    
    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 20
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            )
        ])
    }
    
    private func setupEnrollButtonConstraints() {
        NSLayoutConstraint.activate([
            enrollButton.topAnchor.constraint(
                equalTo: titleLabel.topAnchor
            ),
            enrollButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            )
        ])
    }
    
    private func setupTableViewContraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 40
            ),
            tableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
            tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            )
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupEnrollButton() {
        enrollButton.addTarget(
            self,
            action: #selector(enrollButtonDidTap),
            for: .touchUpInside
        )
    }
    
    @objc
    private func enrollButtonDidTap() {
        let scheduleEnrollViewController = ScheduleEnrollViewController()
        scheduleEnrollViewController.scheuleDelegate = self
        present(scheduleEnrollViewController, animated: true)
    }
}

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return scheduleList.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ScheduleCell.identifier
        ) as? ScheduleCell else {
            return UITableViewCell()
        }
        
        cell.setupCell(with: scheduleList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 100
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: "삭제"
        ) { _, _, _ in
            
            self.scheduleList.remove(at: indexPath.row)
        }
        
        let modifyAction = UIContextualAction(
            style: .normal,
            title: "수정"
        ) { action, view, handler in
            print("modify")
            
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction, modifyAction])
    }
}
