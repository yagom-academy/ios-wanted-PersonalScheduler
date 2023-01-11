//
//  ScheduleListViewController.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/10.
//

import UIKit

final class ScheduleListViewController: UIViewController {

    private let viewModel: ScheduleListViewModel

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var dataSource = diffableDataSource()

    init(viewModel: ScheduleListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        bind()
        setUpCollectionView()
        layout()
        applyDataSource()
        viewModel.viewDidLoad()
    }

    private func bind() {
        viewModel.applyDataSource = {
            self.applyDataSource()
        }
    }

    private func setUpCollectionView() {
        collectionView.dataSource = dataSource
        collectionView.register(ScheduleCollectionViewCell.self,
                                forCellWithReuseIdentifier: ScheduleCollectionViewCell.reuseIdentifier)
        collectionView.register(CalendarCollectionViewCell.self,
                                forCellWithReuseIdentifier: CalendarCollectionViewCell.reuseIdentifier)
    }

    private func layout() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func applyDataSource() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, ItemWrapper>()
        snapShot.appendSections([.calendar, .schedule])
        viewModel.days.forEach {
            snapShot.appendItems([.calendar($0)], toSection: .calendar)
        }

        viewModel.schedules.forEach {
            snapShot.appendItems([.schedule($0)], toSection: .schedule)
        }

        dataSource.apply(snapShot)
    }

    private func compositionalLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, environment in
            return Section(rawValue: sectionIndex)?.section
        }, configuration: configuration)

        return layout
    }

    private func diffableDataSource() -> UICollectionViewDiffableDataSource<Section, ItemWrapper> {
        UICollectionViewDiffableDataSource<Section, ItemWrapper>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch indexPath.section {
            case Section.calendar.rawValue:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CalendarCollectionViewCell.reuseIdentifier,
                    for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell() }
                cell.setUpContents(number: self.viewModel.days[indexPath.row])
                return cell

            case Section.schedule.rawValue:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ScheduleCollectionViewCell.reuseIdentifier,
                    for: indexPath) as? ScheduleCollectionViewCell else { return UICollectionViewCell() }
                cell.setUpContents(schedule: self.viewModel.schedules[indexPath.row])
                return cell

            default:
                return UICollectionViewCell()
            }
        }
    }
}

extension ScheduleListViewController {

    /// Wrapper Enum to use DiffableDataSource
    enum ItemWrapper: Hashable {
        case calendar(Int)
        case schedule(Schedule)
    }
    enum Section: Int, CaseIterable {
        case calendar
        case schedule

        var item: NSCollectionLayoutItem {
            switch self {
            case .calendar:
                let size = NSCollectionLayoutSize(widthDimension: .estimated(10), heightDimension: .estimated(100))
                let item = NSCollectionLayoutItem(layoutSize: size)
                item.edgeSpacing = .init(leading: .fixed(5), top: .fixed(5), trailing: .fixed(5), bottom: .fixed(5))
                return item
            case .schedule:
                let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
                return NSCollectionLayoutItem(layoutSize: size)
            }
        }

        var group: NSCollectionLayoutGroup {
            switch self {
            case .calendar:
                let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(5), heightDimension: .estimated(100))
                return NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])

            case .schedule:
                let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                return NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
            }
        }

        var section: NSCollectionLayoutSection {
            switch self {
            case .calendar:
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                return section
            case .schedule:
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
        }
    }
}
