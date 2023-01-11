//
//  SchedulListVC.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/09.
//

import UIKit

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
        collectionViewBind()
        self.viewModel.input.viewDidLoadTrigger.value = ()
        configureUI()
        configureTableView()
        addButtonAction()
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
    }
    
    private func addButtonAction() {
        schedulePlusButton.addTarget(self, action: #selector(didTapAddSheduleButton), for: .touchUpInside)
    }
    
    @objc private func didTapAddSheduleButton() {
        let addView = InputSchedulVC()
        addView.viewType = .add
        self.navigationController?.pushViewController(addView, animated: true)
    }
}

// MARK: - OutputBind
extension ScheduleListVC {
    private func collectionViewBind() {
        viewModel.output.scheduleList.bind { [weak self] _ in
            self?.scheduleListV.scheduletableView.reloadData()
        }
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
        cell.configureCellData(schedule: list[indexPath.row])
        
        return cell
    }
    
    
}
// MARK: - TableViewDelegate
extension ScheduleListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "삭제") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            let uid = self.viewModel.output.scheduleList.value![indexPath.row].uid
            self.viewModel.input.deleteScheduleTrigger.value = uid
            success(true)
        }
        
        let edit = UIContextualAction(style: .normal, title: "수정") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            let schedule = self.viewModel.output.scheduleList.value![indexPath.row]
            let editView = InputSchedulVC()
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
