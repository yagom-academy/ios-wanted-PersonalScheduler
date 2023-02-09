//
//  ListViewController.swift
//  PersonalScheduler
//
//  Created by junho lee on 2023/02/09.
//

import UIKit
import FirebaseAuth
import FacebookLogin

final class ListViewController: UIViewController {
    private typealias Datasource = UICollectionViewDiffableDataSource<Int, Schedule.ID>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Schedule.ID>

    private var firestoreService: FirestoreService?
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
        configureFirestoreService()
        fetchSchedules()
    }

    private func configureCollectionView() {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.trailingSwipeActionsConfigurationProvider = swipeActions
        let collectionViewLayout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView?.delegate = self
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
                return collectionView.dequeueConfiguredReusableCell(
                    using: cellRegistration,
                    for: indexPath,
                    item: itemIdentifier
                )
            }
        )
    }

    private func configureNavigationItem() {
        navigationItem.title = NSLocalizedString("Personal Scheduler", comment: "Scheduler List ViewController Title")
        let logoutButtonTitle = NSLocalizedString("Logout", comment: "Logout BarButton Title")
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: logoutButtonTitle,
            primaryAction: UIAction(handler: logoutHandler)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            systemItem: .add,
            primaryAction: UIAction(handler: addHandler)
        )
    }

    private func logoutHandler(_ action: UIAction) {
        do {
            try Auth.auth().signOut()
            LoginManager().logOut()
            navigationController?.popViewController(animated: true)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    private func addHandler(_ action: UIAction) {
        let viewController = EditViewController(schedule: Schedule(), isAdding: true) { [weak self] schedule in
            guard let self else { return }
            self.add(schedule)
            self.updateSnapshot()
        }
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true)
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


    private func configureFirestoreService() {
        if let user = Auth.auth().currentUser {
            firestoreService = FirestoreService(collection: user.uid)
        }
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

extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let id = datasource?.itemIdentifier(for: indexPath) else { return false }
        showDetail(for: id)
        return false
    }

    private func showDetail(for id: Schedule.ID) {
        guard let schedule = schedule(for: id) else { return }
        let viewController = EditViewController(schedule: schedule, isAdding: false) { [weak self] schedule in
            guard let self else { return }
            self.update(schedule)
            self.updateSnapshot([schedule.id])
        }
        navigationController?.pushViewController(viewController, animated: true)
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
        firestoreService?.add(schedule)
    }

    private func update(_ schedule: Schedule) {
        guard let index = schedules.firstIndex(where: { $0.id == schedule.id }) else { return }
        schedules[index] = schedule
        firestoreService?.update(schedule)
    }

    private func deleteSchedule(with id: Schedule.ID) {
        guard let schedule = schedule(for: id) else { return }
        firestoreService?.delete(schedule)
        schedules.removeAll(where: { $0.id == id })
    }

    private func highlightColor(for schedule: Schedule) -> UIColor {
        if schedule.scheduleDate.isToday() { return Constants.isTodayColor }
        if schedule.scheduleDate.isEarlierThanToday() { return Constants.isEarlierThanTodayColor }
        return Constants.defaultColor
    }

    private func fetchSchedules() {
        firestoreService?.fetchAll { [weak self] schedules in
            guard let self else { return }
            DispatchQueue.main.async {
                self.schedules = schedules
                self.updateSnapshot()
            }
        }
    }
}

extension ListViewController {
    private enum Constants {
        static let isTodayColor = UIColor.systemGreen
        static let isEarlierThanTodayColor = UIColor.systemGray
        static let defaultColor = UIColor.clear
    }
}
