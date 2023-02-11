//  PersonalScheduler - SchedulerViewController.swift
//  Created by zhilly on 2023/02/08

import UIKit

final class SchedulerViewController: BaseViewController {
    
    // MARK: - Enum, Type alias
    
    enum Section: Hashable {
        case main
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Schedule>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Schedule>
    
    
    // MARK: - Properties
    
    private let viewModel: SchedulerViewModel
    private let userName: String
    
    // MARK: - Views
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = UIColor(named: "AppColor")
        tableView.register(SchedulerTableViewCell.self,
                           forCellReuseIdentifier: SchedulerTableViewCell.reuseIdentifier)
        tableView.register(SchedulerHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: SchedulerHeaderView.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(tableView: tableView) { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SchedulerTableViewCell.reuseIdentifier,
                for: indexPath
            ) as? SchedulerTableViewCell else { return UITableViewCell() }
            
            cell.configure(with: item)
            
            return cell
        }
        
        return dataSource
    }()
    
    // MARK: - Life Cycle
    
    init(viewModel: SchedulerViewModel, userName: String) {
        self.viewModel = viewModel
        self.userName = userName
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
    }
    
    // MARK: - Methods
    
    override func setupView() {
        super.setupView()
        [tableView].forEach(view.addSubview(_:))
    }
    
    override func setupLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
    }
    
    override func bindViewModel() {
        viewModel.model.bind { [weak self] item in
            self?.appendData(item: item)
        }
    }
    
    private func appendData(item: [Schedule]) {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(item)
        dataSource.apply(snapshot)
    }
}

// MARK: - UITableViewDelegate

extension SchedulerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: SchedulerHeaderView.reuseIdentifier
        ) as? SchedulerHeaderView else {
            return UIView()
        }
        
        headerView.configure(userName: self.userName)
        
        return headerView
    }
}
