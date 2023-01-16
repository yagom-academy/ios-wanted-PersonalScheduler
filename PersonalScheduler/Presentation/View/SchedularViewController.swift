//
//  SchedularViewController.swift
//  PersonalScheduler
//
//  Created by 이예은 on 2023/01/12.
//

import UIKit
import Combine

class SchedularViewController: UIViewController {
    private let tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    let viewModel: ScheduleViewModel
    private var cancelable = Set<AnyCancellable>()
    
    init(viewModel: ScheduleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        setup()
        setupAutolayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.input.viewWillAppear()
    }
    
    func bind() {
        viewModel.output._model
            .sink { [weak self] schedules in
                guard let self = self else { return }
                
                self.tableView.reloadData()
            }
            .store(in: &cancelable)
    }
    
    @objc func didTapAddButton() {
        let writingVC = WritingScheduleViewController()
        
        navigationController?.pushViewController(writingVC, animated: true)
    }
    
    func setup() {
        self.view.addSubview(tableView)
        
        tableView.backgroundColor = .Beige
        view.backgroundColor = .Beige
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 30)
        tableView.separatorInsetReference = .fromAutomaticInsets
        tableView.separatorColor = .Red_60
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ScheduleCell.self, forCellReuseIdentifier: "ScheduleCell")
        
        let rightButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(didTapAddButton))
        rightButton.tintColor = .Red
        navigationItem.rightBarButtonItem = rightButton
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backButton.tintColor = .Red
        self.navigationItem.backBarButtonItem = backButton
    }
    
    func setupAutolayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension SchedularViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath) as? ScheduleCell else {
            return UITableViewCell()
        }
        
        cell.transferData(schedule: viewModel.model[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let writingVC = WritingScheduleViewController()
        
        navigationController?.pushViewController(writingVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            self.viewModel.deleteButtonDidTap(indexPath: indexPath)
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
