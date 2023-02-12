//
//  ScheduleViewController.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/08.
//

import UIKit

class ScheduleViewController: UIViewController {
    private let scheduleTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let viewModel: ScheduleViewModel
    private var dataSource: UITableViewDiffableDataSource<String, SchedulePreview>?
    
    init(viewModel: ScheduleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureLayout()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.action(.viewWillAppear)
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        
        viewModel.delegate = self
        
        scheduleTableView.backgroundColor = .systemBackground
        scheduleTableView.sectionFooterHeight = .zero
        scheduleTableView.delegate = self
        scheduleTableView.register(ScheduleCell.self, forCellReuseIdentifier: ScheduleCell.reuseIdentifier)
        scheduleTableView.register(
            ScheduleHeaderView.self,
            forHeaderFooterViewReuseIdentifier: ScheduleHeaderView.reuseIdentifier
        )
        
        view.addSubview(scheduleTableView)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scheduleTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scheduleTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            scheduleTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
            scheduleTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

extension ScheduleViewController {
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<String, SchedulePreview>(
            tableView: scheduleTableView
        ) { tableView, indexPath, schedule in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleCell.reuseIdentifier,
                                                           for: indexPath) as? ScheduleCell
            else {
                return UITableViewCell()
            }
            
            cell.setupCellData(from: schedule)
            return cell
        }
    }
    
    private func updateTableView(with periodWithSchedules: [String : [SchedulePreview]]) {
        var snapshot = NSDiffableDataSourceSnapshot<String, SchedulePreview>()
        let keys = periodWithSchedules.keys.sorted(by: >)
        
        keys.forEach {
            snapshot.appendSections([$0])
            snapshot.appendItems(periodWithSchedules[$0, default: []])
        }
        
        dataSource?.apply(snapshot)
    }
}

extension ScheduleViewController: ScheduleViewModelDelegate {
    func scheduleViewModel(didChange periodWithSchedules: [String : [SchedulePreview]]) {
        updateTableView(with: periodWithSchedules)
    }
    
    func scheduleViewModel(selectedScheduleID id: String) {
        // 3번째 뷰 띄움
    }
    
    func scheduleViewModel(failedFetchData error: RemoteDBError) {
        let alret = AlertBuilder()
            .withStyle(.alert)
            .withTitle("Error")
            .withMessage("An error has occurred. Please try again later. \n \(error.localizedDescription)")
            .withDefaultActions()
            .build()
        
        present(alret, animated: true)
    }
}

extension ScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let schedule = dataSource?.itemIdentifier(for: indexPath) else { return }
        
        viewModel.action(.tapSchedule(section: schedule.startDateString, index: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: ScheduleHeaderView.reuseIdentifier
            ) as? ScheduleHeaderView
        else {
            return UIView()
        }
        viewModel.findSectionTitle(from: section) { headerView.setTitle($0) }
        
        return headerView
    }
}
