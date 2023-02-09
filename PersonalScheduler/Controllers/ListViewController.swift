//
//  ListViewController.swift
//  PersonalScheduler
//
//  Created by junho lee on 2023/02/09.
//

import UIKit

final class ListViewController: UIViewController {
    private typealias Datasource = UICollectionViewDiffableDataSource<Int, Schedule.ID>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Schedule.ID>

    private var collectionView: UICollectionView?
    private var datasource: Datasource?
    private var schedules = [Schedule]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCollectionView()
        configureDataSources()
        configureNavigationItem()
        configureHierarchy()
    }

    private func configureCollectionView() {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.trailingSwipeActionsConfigurationProvider = swipeActions
        let collectionViewLayout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    }

    private func swipeActions(for indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let id = datasource?.itemIdentifier(for: indexPath) else { return nil }
        let deleteActionTitle = NSLocalizedString("Delete", comment: "Delete Action Title")
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: deleteActionTitle) { [weak self] _, _, completion in
            guard let self else { return }
            self.deleteSchedule(with: id)
            self.updateSnapshot()
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    private func configureDataSources() {
        guard let collectionView else { return }
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        datasource = Datasource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: itemIdentifier)
            }
        )
    }

    private func configureNavigationItem() {
        navigationItem.title = NSLocalizedString("Personal Scheduler", comment: "Scheduler List ViewController Title")
        navigationItem.hidesBackButton = true
    }

    private func configureHierarchy() {
        guard let collectionView else { return }
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ListViewController {
    private func updateSnapshot(_ reloadItems: [UUID] = []) {
        guard let datasource else { return }
        let itemIDs = scheduleIDs()
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(itemIDs)
        if reloadItems.isEmpty == false {
            snapshot.reloadItems(reloadItems)
        }
        datasource.apply(snapshot)
    }

    private func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: UUID) {
        var configuration = ListContentView.Configuration()
        guard let schedule = schedule(for: itemIdentifier) else {
            cell.contentConfiguration = configuration
            return
        }

        configuration.title = schedule.title
        configuration.scheduleDateText = schedule.scheduleDate.localizedDateTimeString()
        configuration.body = schedule.body
        configuration.highlightColor = highlightColor(for: schedule)
        cell.contentConfiguration = configuration
    }
}

extension ListViewController {
    private func schedule(for id: Schedule.ID) -> Schedule? {
        return schedules.first(where: { $0.id == id })
    }

    private func scheduleIDs() -> [Schedule.ID] {
        return schedules.sorted(by: { $0.scheduleDate > $1.scheduleDate }).map { $0.id }
    }

    private func add(_ schedule: Schedule) {
        schedules.append(schedule)
    }

    private func update(_ schedule: Schedule) {
        guard let index = schedules.firstIndex(where: { $0.id == schedule.id }) else { return }
        schedules[index] = schedule
    }

    private func deleteSchedule(with id: Schedule.ID) {
        schedules.removeAll(where: { $0.id == id })
    }

    private func highlightColor(for schedule: Schedule) -> UIColor {
        if schedule.scheduleDate.isToday() { return Constants.isTodayColor }
        if schedule.scheduleDate.isEarlierThanToday() { return Constants.isEarlierThanTodayColor }
        return Constants.defaultColor
    }
}

extension ListViewController {
    private enum Constants {
        static let isTodayColor = UIColor.systemGreen
        static let isEarlierThanTodayColor = UIColor.systemGray
        static let defaultColor = UIColor.clear
    }
}
