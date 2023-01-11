//
//  ScheduleListViewController.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/10.
//

import UIKit

final class ScheduleListViewController: UIViewController {

    private let viewModel: ScheduleListViewModel

    private lazy var previousMonthButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowtriangle.backward.fill"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let currentMonthLabel: UILabel = {
        let label = UILabel()
        label.text = "2023년 1월"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nextMonthButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowtriangle.forward.fill"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var calendarCollectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            return CalendarSection.calendar.section
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var scheduleCollectionView: UICollectionView = {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 10
        let layout = UICollectionViewCompositionalLayout(sectionProvider:({ sectionIndex, environment in
            return ScheduleSection.current.section
        }), configuration: configuration)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()

    private lazy var calendarCollectionViewDataSource = calendarDataSource()
    private lazy var scheduleCollectionViewDataSource = scheduleDataSource()

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
        setUpCollectionViews()
        layout()
        viewModel.viewDidLoad()
    }

    private func bind() {
        viewModel.applyDataSource = {
            self.applyCalendarCollectionViewDataSource()
            self.applyScheduleCollectionViewDataSource()
        }
    }

    private func setUpCollectionViews() {
        calendarCollectionView.dataSource = calendarCollectionViewDataSource
        calendarCollectionView.register(CalendarCollectionViewCell.self,
                                forCellWithReuseIdentifier: CalendarCollectionViewCell.reuseIdentifier)
        scheduleCollectionView.dataSource = scheduleCollectionViewDataSource
        scheduleCollectionView.register(ScheduleCollectionViewCell.self,
                                forCellWithReuseIdentifier: ScheduleCollectionViewCell.reuseIdentifier)
        scheduleCollectionView.register(ScheduleListHeader.self,
                                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                        withReuseIdentifier: ScheduleListHeader.reuseIdentifier)
    }

    private func layout() {
        [previousMonthButton, currentMonthLabel, nextMonthButton, calendarCollectionView, scheduleCollectionView].forEach {
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            currentMonthLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            currentMonthLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),

            previousMonthButton.trailingAnchor.constraint(equalTo: currentMonthLabel.leadingAnchor, constant: -10),
            previousMonthButton.topAnchor.constraint(equalTo: currentMonthLabel.topAnchor),

            nextMonthButton.leadingAnchor.constraint(equalTo: currentMonthLabel.trailingAnchor, constant: 10),
            nextMonthButton.topAnchor.constraint(equalTo: currentMonthLabel.topAnchor),

            calendarCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            calendarCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            calendarCollectionView.topAnchor.constraint(equalTo: currentMonthLabel.bottomAnchor, constant: 20),
            calendarCollectionView.heightAnchor.constraint(equalToConstant: 40),

            scheduleCollectionView.topAnchor.constraint(equalTo: calendarCollectionView.bottomAnchor, constant: 10),
            scheduleCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scheduleCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scheduleCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func applyCalendarCollectionViewDataSource() {
        var snapShot = NSDiffableDataSourceSnapshot<CalendarSection, Int>()
        snapShot.appendSections([.calendar])
        snapShot.appendItems(viewModel.days)
        calendarCollectionViewDataSource.apply(snapShot)
    }

    private func applyScheduleCollectionViewDataSource() {
        var snapShot = NSDiffableDataSourceSnapshot<ScheduleSection, Schedule>()
        snapShot.appendSections([.current, .upcoming, .done])
        ScheduleSection.allCases.forEach {
            snapShot.appendItems(viewModel.schedules(section: $0), toSection: $0)
        }
        scheduleCollectionViewDataSource.apply(snapShot)
    }

    private func calendarDataSource() -> UICollectionViewDiffableDataSource<CalendarSection, Int> {
        return UICollectionViewDiffableDataSource<CalendarSection, Int>(collectionView: scheduleCollectionView) { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CalendarCollectionViewCell.reuseIdentifier,
                for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell() }
            cell.setUpContents(number: self.viewModel.days[indexPath.row])
            return cell
        }
    }

    private func scheduleDataSource() -> UICollectionViewDiffableDataSource<ScheduleSection, Schedule> {
        let dataSource = UICollectionViewDiffableDataSource<ScheduleSection, Schedule>(collectionView: scheduleCollectionView) { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ScheduleCollectionViewCell.reuseIdentifier,
                for: indexPath) as? ScheduleCollectionViewCell else { return UICollectionViewCell() }
            let section = ScheduleSection(rawValue: indexPath.section) ?? .done
            cell.setUpContents(section: section,
                               schedule: self.viewModel.schedules(section: section)[indexPath.row])
            return cell
        }

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: ScheduleListHeader.reuseIdentifier,
                for: indexPath) as? ScheduleListHeader else { return UICollectionReusableView() }
            let section = ScheduleSection(rawValue: indexPath.section) ?? .done
            header.setUpContents(title: section.title)
            return header
        }

        return dataSource
    }
}

extension ScheduleListViewController {

    enum CalendarSection {
        case calendar

        var item: NSCollectionLayoutItem {
            let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/7), heightDimension: .estimated(40))
            let item = NSCollectionLayoutItem(layoutSize: size)
            return item
        }

        var group: NSCollectionLayoutGroup {
            let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
            return NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
        }

        var section: NSCollectionLayoutSection {
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            return section
        }
    }

    enum ScheduleSection: Int, CaseIterable {
        case current
        case upcoming
        case done

        var item: NSCollectionLayoutItem {
            let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
            return NSCollectionLayoutItem(layoutSize: size)
        }

        var group: NSCollectionLayoutGroup {
            let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1000))
            return NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
        }

        var header: NSCollectionLayoutBoundarySupplementaryItem {
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(0.1)
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            return header
        }

        var section: NSCollectionLayoutSection {
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [header]
            return section
        }

        var stateColor: UIColor {
            switch self {
            case .current:
                return .systemTeal
            case .upcoming:
                return .systemGreen
            case .done:
                return .systemGray4
            }
        }

        var title: String {
            switch self {
            case .current:
                return "현재 진행중"
            case .upcoming:
                return "예정된 일정"
            case .done:
                return "완료된 일정"
            }
        }
    }
}
