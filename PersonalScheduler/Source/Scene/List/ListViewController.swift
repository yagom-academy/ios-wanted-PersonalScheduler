//
//  ListViewController.swift
//  PersonalScheduler
//
//  Created by Kyo on 2023/02/09.
//

import UIKit

final class ListViewController: UIViewController {
    typealias DataSource = UITableViewDiffableDataSource<Section, Schedule>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Schedule>
    
    enum Section {
        case main
    }
    
    private let viewModel: ListViewModel
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private lazy var dataSource = configureDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        setupConstraint()
        setupBind()
    }
    
    init(_ viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.presentDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBind() {
        viewModel.bindData { [weak self] datas in
            self?.applySnapshot(data: datas, animating: true)
        }
    }
}

// MARK: - Present
extension ListViewController: EventManageable {
    func presentDetailView(mode: Mode, data: Schedule?) {
        let detailViewModel = DetailViewModel(mode: mode, data: data)
        let detailView = DetailViewController(viewModel: detailViewModel, delegate: self)
        navigationController?.pushViewController(detailView, animated: true)
    }
    
    @objc private func addButtonTapped() {
        viewModel.dataAction(.present(index: nil))
    }
}

// MARK: - DataSource and Snapshot
extension ListViewController {
    private func configureDataSource() -> DataSource {
        let dataSource = DataSource(tableView: tableView) { tableView, indexPath, schedule in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ScheduleTableViewCell.identifier,
                for: indexPath
            ) as? ScheduleTableViewCell else {
                let errorCell = UITableViewCell()
                return errorCell
            }
            
            cell.setupData(CellViewModel(data: schedule), delegate: self)
            return cell
        }
        return dataSource
    }
    
    private func applySnapshot(data: [Schedule], animating: Bool) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        
        dataSource.apply(snapshot, animatingDifferences: animating)
    }
}

// MARK: - TableViewDelegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.dataAction(.present(index: indexPath.row))
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(
            style: .normal,
            title: "삭제") { [weak self] _, _, _ in
                guard let self = self else { return }
                self.viewModel.dataAction(.delete(index: indexPath.row))
            }
        
        delete.backgroundColor = .systemOrange
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [delete])
        
        return swipeConfiguration
    }
}

extension ListViewController: DataManageable {
    func uploadData(mode: Mode, _ data: Schedule) {
        viewModel.dataAction(.upload(mode: mode, data: data))
    }
    
    func updateProcess(data: Schedule) {
        viewModel.dataAction(.processUpdate(data: data))
    }
}

// MARK: - UIConstraint
extension ListViewController {
    private func setupNavigationBar() {
        title = viewModel.fetchName() + "님의 Schedule"
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemGray6
        
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .systemOrange
        navigationController?.navigationBar.topItem?.title = "Schedules"
        
        let addBarButton = UIBarButtonItem(
            image: UIImage(systemName: "plus.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(addButtonTapped)
        )
        
        addBarButton.tintColor = .systemOrange
        navigationItem.rightBarButtonItem = addBarButton
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(
            top: .zero, left: .zero, bottom: .zero, right: .zero
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            ScheduleTableViewCell.self,
            forCellReuseIdentifier: ScheduleTableViewCell.identifier
        )
    }
    
    private func setupConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}
