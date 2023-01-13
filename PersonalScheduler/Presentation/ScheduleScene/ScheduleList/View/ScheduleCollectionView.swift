//
//  ScheduleCollectionView.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/12.
//

import UIKit

final class ScheduleCollectionView: UICollectionView {
    
    private enum Section {
        case main
    }
    
    private let viewModel: ScheduleListViewModel
    private var scheduleDataSource: UICollectionViewDiffableDataSource<Section, Schedule>?
    private var snapshot = NSDiffableDataSourceSnapshot<Section, Schedule>()
    
    init(viewModel: ScheduleListViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        configureHierachy()
        configureDataSource(with: createCellRegistration())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierachy() {
        frame = bounds
        collectionViewLayout = createListLayout()
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    private func createListLayout() -> UICollectionViewLayout {
        let sectionProvider = { (_: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let section: NSCollectionLayoutSection
            var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            configuration.trailingSwipeActionsConfigurationProvider = { [weak self] (indexPath) in
                guard let self = self else { return nil }
                guard let item = self.scheduleDataSource?.itemIdentifier(for: indexPath) else { return nil }
                return self.trailingSwipeActionConfigurationForListCellItem(item)
            }
            section = NSCollectionLayoutSection.list(
                using: configuration,
                layoutEnvironment: layoutEnvironment
            )
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: 20,
                bottom: 0,
                trailing: 20
            )
            section.interGroupSpacing = 15
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    private func trailingSwipeActionConfigurationForListCellItem(_ item: Schedule) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") { [weak self] (_, _, completion) in
            self?.deleteData(with: [item])
            Task {
                try await self?.viewModel.deleteSchedule(item)
            }
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
  
    private func configureDataSource<T: UICollectionViewCell>(with cellRegistration: UICollectionView.CellRegistration<T, Schedule>) {
        scheduleDataSource = createDataSource(with: cellRegistration)
        snapshot.appendSections([.main])
        scheduleDataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    private func createCellRegistration() -> UICollectionView.CellRegistration<ListCell, Schedule> {
        let cellRegistration = UICollectionView.CellRegistration<ListCell, Schedule> { (cell, _, item) in
            cell.setup(with: item)
        }
        return cellRegistration
    }
    
    private func createDataSource<T: UICollectionViewCell>(with cellRegistration: UICollectionView.CellRegistration<T, Schedule>) -> UICollectionViewDiffableDataSource<Section, Schedule>? {
        let dataSource = UICollectionViewDiffableDataSource<Section, Schedule>(collectionView: self) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Schedule) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        return dataSource
    }
    
    func appendData(with cellDatas: [Schedule]) {
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        snapshot.appendItems(cellDatas, toSection: .main)
        scheduleDataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    func deleteData(with cellDatas: [Schedule]) {
        snapshot.deleteItems(cellDatas)
        scheduleDataSource?.apply(snapshot)
    }
}
