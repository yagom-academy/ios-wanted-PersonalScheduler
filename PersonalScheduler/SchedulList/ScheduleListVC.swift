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
        self.navigationController?.pushViewController(InputSchedulVC(), animated: true)
    }
}
// MARK: - TableViewDatasource
extension ScheduleListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleCell.cellID, for: indexPath) as? ScheduleCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    
}
// MARK: - TableViewDelegate
extension ScheduleListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "Delete") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in

            success(true)
        }
        delete.backgroundColor = .systemRed
        
        let swipeActionConfiguration = UISwipeActionsConfiguration(actions:[delete])
        swipeActionConfiguration.performsFirstActionWithFullSwipe = false
        return swipeActionConfiguration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
