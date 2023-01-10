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

