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
    var scheduleListTableViewDataSource: ScheduleDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.loadItems()
    }

    override func setupView() {
        view.backgroundColor = .systemBackground
        
        configureTableViewDataSource()
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
    
    override func bindViewModel() {
    }
    
}

// MARK: TableView DataSource

extension ScheduleListViewController {
    
    private func configureTableViewDataSource() {
        self.scheduleListTableViewDataSource = ScheduleDataSource(tableView: scheduleListTableView, cellProvider: { tableView, indexPath, category in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.cellIdentifier, for: indexPath) as? ScheduleTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.configure(information: self.viewModel.items.value[indexPath.row])
            return cell
        })
        
        self.configureTableViewSnapshot()
    }
    
    func configureTableViewSnapshot(animatingDifferences: Bool = false) {
        
        self.viewModel.items.subscribe { [weak self] item in
            var snapshot = NSDiffableDataSourceSnapshot<MainSection, ScheduleInfo>()
            snapshot.appendSections([.main])
            snapshot.appendItems(item, toSection: .main)
            self?.scheduleListTableViewDataSource?.apply(snapshot, animatingDifferences: animatingDifferences)
        }
    }
}

// MARK: TableView SwipeAction

extension ScheduleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let updateAction = UIContextualAction(style: .normal, title: "수정") { _, _, completionHandler in
            self.goToUpdateScheduleScene()
            completionHandler(true)
        }
        updateAction.backgroundColor = UIColor.blue
        
        let deleteAction = UIContextualAction(style: .normal, title: "삭제") { _, _, completionHandler in
            self.viewModel.deleteItem(index: indexPath.row)
            completionHandler(true)
        }
        deleteAction.backgroundColor = UIColor.red
        
        return UISwipeActionsConfiguration(actions: [deleteAction, updateAction])
    }
}

// MARK: Navigation

private extension ScheduleListViewController {
    func configureNavigationBar() {
        let addButton = UIBarButtonItem(title: "추가",
                                            style: .done,
                                            target: self,
                                            action: #selector(goToAddScheduleScene))

        navigationItem.rightBarButtonItem = addButton
        navigationItem.title = "제리네 일정"
    }
    
    @objc func goToAddScheduleScene() {
        let scheduleAddViewController = ScheduleEditViewController(editType: .add)
        navigationController?.pushViewController(scheduleAddViewController, animated: true)
    }
    
    func goToUpdateScheduleScene() {
        let scheduleAddViewController = ScheduleEditViewController(editType: .update)
        let navigationController = UINavigationController(rootViewController: scheduleAddViewController)
        
        self.navigationController?.present(navigationController, animated: true)
    }
}
