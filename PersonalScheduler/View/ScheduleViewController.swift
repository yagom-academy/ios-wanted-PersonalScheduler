//
//  ScheduleViewController.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 2023/02/08.
//

import UIKit

final class ScheduleViewController: UIViewController {

    typealias DataSource = UITableViewDiffableDataSource<ScheduleSection, Event>
    typealias Snapshot = NSDiffableDataSourceSnapshot<ScheduleSection, Event>

    private let viewModel: ScheduleViewModel
    private let scheduleTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .custom)
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .large)
        let plusImage =  UIImage(systemName: "plus", withConfiguration: imageConfiguration)?
            .withTintColor(.tertiary ?? .white, renderingMode: .alwaysOriginal)
        button.setImage(plusImage, for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = .secondary
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(touchedUpPlusButton), for: .touchUpInside)

        return button
    }()

    private var dataSource: DataSource? = nil
    private let snapshot: Snapshot = Snapshot()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        scheduleTableView.delegate = self
        configureHierarchy()
        configureLayout()
        bindViewModel()
        initialSetup()
        configureDateDataSource()
    }

    init(scheduleViewModel: ScheduleViewModel) {
        self.viewModel = scheduleViewModel
        super.init(nibName: nil, bundle: nil)
    }

    private func bindViewModel() {
        viewModel.events.bind { [weak self] events in
            guard var snapshot = self?.dataSource?.snapshot() else { return }
            snapshot.deleteAllItems()
            snapshot.appendSections([.main])
            snapshot.appendItems(events)
            self?.dataSource?.apply(snapshot)
        }
    }

    private func initialSetup() {
        viewModel.fetchEvents()
    }

    private func configureDateDataSource() {
        registerCell()

        dataSource = DataSource(tableView: scheduleTableView) {tableView, indexPath, event in
            let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleCell.reuseIdentifier) as? ScheduleCell
            let scheduleCellViewModel = ScheduleCellViewModel(event: event)
            cell?.delegate = self
            cell?.configureCell(with: scheduleCellViewModel)
            cell?.highlightToday(of: scheduleCellViewModel)
            cell?.addActionToCheckButton(of: scheduleCellViewModel)

            return cell
        }
    }

    private func registerCell() {
        scheduleTableView.register(ScheduleCell.self, forCellReuseIdentifier: ScheduleCell.reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func touchedUpPlusButton() {
        let registerViewController =  RegisterViewController(viewModel: RegisterViewModel())
        registerViewController.delegate = self
        self.modalPresentationStyle = .popover
        self.present(registerViewController, animated: true)
    }
}

//MARK: - tableViewDelegate
extension ScheduleViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = viewModel.fetchEvent(index: indexPath.row)
        let registerViewController =  RegisterViewController(viewModel: RegisterViewModel(event: event))
        registerViewController.delegate = self
        self.modalPresentationStyle = .popover
        self.present(registerViewController, animated: true)
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, _ in
            guard let uuid = self?.viewModel.fetchEvent(index: indexPath.item).uuid else { return }
            self?.viewModel.removeEvent(of: uuid)
        }

        return UISwipeActionsConfiguration(actions: [removeAction])
    }
}

//MARK: - ScheduleCellDelegate
extension ScheduleViewController: ScheduleCellDelegate {

    func touchedUpCheckButton(of viewModel: ScheduleCellViewModel) {
        self.viewModel.removeEvent(of: viewModel.uuid)
    }
}

//MARK: - RegisterViewControllerDelegate
extension ScheduleViewController: RegisterViewControllerDelegate {

    func registerEvent(state: RegisterViewModel.State,
                       title: String?,
                       date: Date,
                       startTime: Date,
                       endTime: Date,
                       description: String,
                       uuid: UUID) {
        let event = self.viewModel.generateEvent(title: title,
                                                 date: date,
                                                 startTime: startTime,
                                                 endTime: endTime,
                                                 description: description,
                                                 uuid: uuid)

        self.viewModel.addEvent(of: event, state: state)
    }
}

//MARK: - ViewHierarchy and Layout
extension ScheduleViewController {

    private func configureHierarchy() {
        self.view.addSubview(scheduleTableView)
        scheduleTableView.addSubview(plusButton)
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            scheduleTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scheduleTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scheduleTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scheduleTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            plusButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            plusButton.heightAnchor.constraint(equalTo: plusButton.widthAnchor),
            plusButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            plusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
}

extension ScheduleViewController {

    enum ScheduleSection {
        case main
    }
}
