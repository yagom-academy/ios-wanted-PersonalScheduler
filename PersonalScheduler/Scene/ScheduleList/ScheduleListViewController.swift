//
//  ScheduleListViewController.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/12.
//

import UIKit

final class ScheduleListViewController: BaseViewController {

    private lazy var scheduleListTableView: UITableView = {
       let tableView = UITableView()
       tableView.delegate = self
       tableView.dataSource = self
       tableView.register(
           ScheduleTableViewCell.self,
           forCellReuseIdentifier: ScheduleTableViewCell.cellIdentifier
       )
       tableView.translatesAutoresizingMaskIntoConstraints = false
       return tableView
   }()
    
    private let indicatorView: UIRefreshControl = {
        let indicatorView = UIRefreshControl()
        return indicatorView
    }()
    
    private var viewModel: ScheduleListViewModel = ScheduleListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bind(to: viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.loadItems()
    }

    override func setupView() {
        view.backgroundColor = .systemBackground
        title = "제리네 일정"
    }
    
    override func addView() {
        view.addSubview(scheduleListTableView)
    }
    
    override func setLayout() {
        NSLayoutConstraint.activate([
            scheduleListTableView.topAnchor.constraint(equalTo: view.topAnchor),
            scheduleListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scheduleListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scheduleListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bind(to viewModel: ScheduleListViewModel) {
        viewModel.items.subscribe() { [weak self] _ in self?.updateItem() }
    }
}

// MARK: TableView Delegate

extension ScheduleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushScheduleDetailScene(information: self.viewModel.items.value[indexPath.row])
    }
}

// MARK: TableView DataSource

extension ScheduleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.cellIdentifier, for: indexPath) as? ScheduleTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configure(information: self.viewModel.items.value[indexPath.row])
        return cell
    }
    
    private func updateItem() {
        DispatchQueue.main.async {
            self.scheduleListTableView.reloadData()
        }
    }
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
         let offsetY = scheduleListTableView.contentOffset.y
         let contentHeight = scrollView.contentSize.height
         let height = scrollView.frame.height
         
         if offsetY > (contentHeight - height) {
             if !viewModel.isloading.value {
                 self.viewModel.loadItems()
             }
         }
    }
}

// MARK: NavigationController

extension ScheduleListViewController {
    
    private func pushScheduleDetailScene(information: ScheduleInfo) {
//        let motionResultViewModel = MotionResultViewModel(information)
//
//        let motionResultViewController = MotionResultViewController(viewModel: motionResultViewModel)
//        navigationController?.pushViewController(motionResultViewController, animated: true)
    }
}

// MARK: TableView SwipeAction

extension ScheduleListViewController {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let updateAction = UIContextualAction(style: .normal, title: "Play") { _, _, completionHandler in
            
            completionHandler(true)
        }
        updateAction.backgroundColor = .systemGreen
        
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { _, _, completionHandler in
            self.viewModel.deleteItem(information: self.viewModel.items.value[indexPath.row])
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [deleteAction, updateAction])
    }
}


