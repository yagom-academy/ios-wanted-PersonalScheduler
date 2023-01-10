//
//  ViewController.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit

class ScheduleListViewController: UIViewController {
    private let schduleTableview: UITableView = {
        let tableVeiw = UITableView(frame: .zero, style: .grouped)
        tableVeiw.register(ScheduleListTableViewCell.self,
                           forCellReuseIdentifier: ScheduleListTableViewCell.identifier)
        tableVeiw.translatesAutoresizingMaskIntoConstraints = false
        return tableVeiw
    }()
    
    private let scheduleViewModel = ScheduleViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadSchedules()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        bind()
    }
    
    private func bind() {
        scheduleViewModel.schedules
            .subscribe { [weak self] scheduled in
                self?.schduleTableview.reloadData()
        }
    }
    
    private func loadSchedules() {
        scheduleViewModel.fetch(at: "judy")
    }
    
    private func setupView() {
        setupConstraint()
        view.backgroundColor = .systemBackground
    }
    
    private func setupConstraint() {
        view.addSubview(schduleTableview)
        
        NSLayoutConstraint.activate([
            schduleTableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                  constant: 8),
            schduleTableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                  constant: -8),
            schduleTableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                  constant: 16),
            schduleTableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                  constant: -16),
        ])
    }
}

extension ScheduleListViewController: UITableViewDataSource {
    private func setupTableView() {
        schduleTableview.dataSource = self
        schduleTableview.rowHeight = view.bounds.height * 0.1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleViewModel.schedules.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleListTableViewCell.identifier,
                                                       for: indexPath) as? ScheduleListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.congigure(with: scheduleViewModel.schedules.value[indexPath.row])
        
        return cell
    }
}

