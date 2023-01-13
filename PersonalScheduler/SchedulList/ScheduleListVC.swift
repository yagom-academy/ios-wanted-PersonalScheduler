//
//  SchedulListVC.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/09.
//

import UIKit

enum RefreshControlType {
    case tableView
    case activity
}

class ScheduleListVC: BaseVC {
    // MARK: - View
    private let scheduleListV = ScheduleListV()
    private let schedulePlusButton = SchedulePlusButton()
    
    override func loadView() {
        self.view = scheduleListV
    }
    
    // MARK: - ViewModel
    private let viewModel = ScheduleListVM()
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scheduleListV.indicator.startAnimating()
        collectionViewBind()
        self.viewModel.input.viewDidLoadTrigger.value = ()
        configureUI()
        configureTableView()
        addButtonAction()
        addObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isHiddenBackButton()
    }
}
// MARK: - Configure
extension ScheduleListVC {
    private func configureUI() {
        isHiddenBackButton()
        setTitle(title: "일정 목록")
        isLargeTitle()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: schedulePlusButton)
    }
    
    private func configureTableView() {
        scheduleListV.scheduletableView.dataSource = self
        scheduleListV.scheduletableView.delegate = self
        scheduleListV.scheduletableView.refreshControl = scheduleListV.tableViewRefreshControl
        scheduleListV.tableViewRefreshControl.addTarget(self, action: #selector(didTableViewRefresh), for: .valueChanged)
    }
    
    private func addButtonAction() {
        schedulePlusButton.addTarget(self, action: #selector(didTapAddSheduleButton), for: .touchUpInside)
    }
    
    @objc private func didTapAddSheduleButton() {
        let addView = InputScheduleVC()
        addView.viewType = .add
        self.navigationController?.pushViewController(addView, animated: true)
    }
    
    @objc private func didTableViewRefresh() {
        DispatchQueue.main.async { [weak self] in
            self?.scheduleListV.tableViewRefreshControl.endRefreshing()
            self?.viewModel.output.currentDate = Date()
            self?.scheduleListV.scheduletableView.reloadData()
        }
    }
}

// MARK: - OutputBind
extension ScheduleListVC {
    private func collectionViewBind() {
        viewModel.output.scheduleList.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.scheduleListV.scheduletableView.reloadData()
                self?.scheduleListV.indicator.stopAnimating()
            }
        }
        
        viewModel.output.completion.bind { [weak self] error in
            if let error {
                AlertManager.shared.showErrorAlert(error: error, viewController: self!)
            }
        }
    }
}
// MARK: - Notification
extension ScheduleListVC {
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: Notification.Name("refreshData"), object: nil)
    }
    
    @objc private func refreshData() {
        self.scheduleListV.indicator.startAnimating()
        self.viewModel.fetchSchedulList()
        self.viewModel.output.currentDate = Date()
    }
}
// MARK: - TableViewDatasource
extension ScheduleListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let list = self.viewModel.output.scheduleList.value else {
            return 0
        }
        
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleCell.cellID, for: indexPath) as? ScheduleCell else {
            return UITableViewCell()
        }
        
        guard let list = self.viewModel.output.scheduleList.value else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.configureCellData(schedule: list[indexPath.row], currentDate: self.viewModel.output.currentDate)
        
        return cell
    }
}
// MARK: - TableViewDelegate
extension ScheduleListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "삭제") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            self.scheduleListV.indicator.startAnimating()
            let uid = self.viewModel.output.scheduleList.value![indexPath.row].uid
            self.viewModel.input.deleteScheduleTrigger.value = uid
            success(true)
        }
        
        let edit = UIContextualAction(style: .normal, title: "수정") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            let schedule = self.viewModel.output.scheduleList.value![indexPath.row]
            let editView = InputScheduleVC()
            editView.viewType = .edit(schedule: schedule)
            
            self.navigationController?.pushViewController(editView, animated: true)
            success(true)
        }
        
        delete.backgroundColor = .systemRed
        edit.backgroundColor = .systemBlue
        
        let swipeActionConfiguration = UISwipeActionsConfiguration(actions:[delete, edit])
        swipeActionConfiguration.performsFirstActionWithFullSwipe = false
        return swipeActionConfiguration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
