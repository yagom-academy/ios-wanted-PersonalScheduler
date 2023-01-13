//
//  ScheduleListViewController.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/10.
//

import UIKit

final class ScheduleListViewController: UIViewController {

    private var coordinator: ScheduleListCoordinator?
    private let viewModel: ScheduleListViewModel

    private lazy var todayButton: UIButton = {
        let button = UIButton()
        button.setTitle("오늘", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction { _ in
            self.viewModel.todayButtonTapped()
        }, for: .touchUpInside)
        return button
    }()

    private lazy var previousMonthButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowtriangle.backward.fill"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction { _ in
            self.viewModel.previousMonthButtonTapped()
        }, for: .touchUpInside)
        return button
    }()

    private let currentMonthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nextMonthButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowtriangle.forward.fill"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction { _ in
            self.viewModel.nextMonthButtonTapped()
        }, for: .touchUpInside)
        return button
    }()

    private lazy var moveToScheduleMakingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
        button.tintColor = .systemBlue
        button.backgroundColor = .white
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction { _ in
            self.coordinator?.showScheduleMaking()
        }, for: .touchUpInside)
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
        collectionView.allowsMultipleSelection = true

        return collectionView
    }()

    private lazy var calendarCollectionViewDataSource = calendarDataSource()
    private lazy var scheduleCollectionViewDataSource = scheduleDataSource()

    init(viewModel: ScheduleListViewModel, coordinator: ScheduleListCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpCollectionViews()
        setupLongGestureRecognizerOnCollection()
        layout()
        bind()
        viewModel.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewWillAppear()
    }

    private func setupLongGestureRecognizerOnCollection() {
        let longPressedGesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(handleLongPress(gestureRecognizer:))
        )
        longPressedGesture.minimumPressDuration = 0.5
        longPressedGesture.delaysTouchesBegan = true
        scheduleCollectionView.addGestureRecognizer(longPressedGesture)
    }

    private func bind() {
        viewModel.applyCalendarDataSource = { [weak self] in
            DispatchQueue.main.async {
                self?.applyCalendarCollectionViewDataSource()
            }
        }
        viewModel.applyScheduleDataSource = { [weak self] in
            DispatchQueue.main.async {
                self?.applyScheduleCollectionViewDataSource()
            }
        }

        viewModel.setCurrentMonthLabel = { [weak self] text in
            self?.currentMonthLabel.text = text
        }

        viewModel.selectItemAt = { [weak self] indexPath in
            DispatchQueue.main.async {
                self?.calendarCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            }
        }
    }

    private func setUpCollectionViews() {
        calendarCollectionView.dataSource = calendarCollectionViewDataSource
        calendarCollectionView.register(CalendarCollectionViewCell.self,
                                forCellWithReuseIdentifier: CalendarCollectionViewCell.reuseIdentifier)
        calendarCollectionView.delegate = self

        scheduleCollectionView.dataSource = scheduleCollectionViewDataSource
        scheduleCollectionView.register(ScheduleCollectionViewCell.self,
                                forCellWithReuseIdentifier: ScheduleCollectionViewCell.reuseIdentifier)
        scheduleCollectionView.register(ScheduleListHeader.self,
                                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                        withReuseIdentifier: ScheduleListHeader.reuseIdentifier)
        scheduleCollectionView.delegate = self
    }

    private func layout() {
        [todayButton, previousMonthButton, currentMonthLabel, nextMonthButton, calendarCollectionView, scheduleCollectionView, moveToScheduleMakingButton].forEach {
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            todayButton.trailingAnchor.constraint(equalTo: previousMonthButton.leadingAnchor, constant: -20),
            todayButton.centerYAnchor.constraint(equalTo: currentMonthLabel.centerYAnchor),
            todayButton.widthAnchor.constraint(equalToConstant: 50),
            todayButton.topAnchor.constraint(equalTo: currentMonthLabel.topAnchor),
            todayButton.bottomAnchor.constraint(equalTo: currentMonthLabel.bottomAnchor),

            currentMonthLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            currentMonthLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),

            previousMonthButton.trailingAnchor.constraint(equalTo: currentMonthLabel.leadingAnchor, constant: -10),
            previousMonthButton.centerYAnchor.constraint(equalTo: currentMonthLabel.centerYAnchor),

            nextMonthButton.leadingAnchor.constraint(equalTo: currentMonthLabel.trailingAnchor, constant: 10),
            nextMonthButton.centerYAnchor.constraint(equalTo: currentMonthLabel.centerYAnchor),

            calendarCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            calendarCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            calendarCollectionView.topAnchor.constraint(equalTo: currentMonthLabel.bottomAnchor, constant: 20),
            calendarCollectionView.heightAnchor.constraint(equalToConstant: 40),

            scheduleCollectionView.topAnchor.constraint(equalTo: calendarCollectionView.bottomAnchor, constant: 10),
            scheduleCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scheduleCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scheduleCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            moveToScheduleMakingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            moveToScheduleMakingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            moveToScheduleMakingButton.widthAnchor.constraint(equalToConstant: 60),
            moveToScheduleMakingButton.heightAnchor.constraint(equalTo: moveToScheduleMakingButton.widthAnchor)
        ])
    }

    private func applyCalendarCollectionViewDataSource() {
        var snapShot = NSDiffableDataSourceSnapshot<CalendarSection, Date>()
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

    private func calendarDataSource() -> UICollectionViewDiffableDataSource<CalendarSection, Date> {
        return UICollectionViewDiffableDataSource<CalendarSection, Date>(collectionView: calendarCollectionView) { collectionView, indexPath, date in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CalendarCollectionViewCell.reuseIdentifier,
                for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell() }
            cell.setUpContents(number: Calendar.current.dateComponents([.day], from: date).day!)
            return cell
        }
    }

    private func scheduleDataSource() -> UICollectionViewDiffableDataSource<ScheduleSection, Schedule> {
        let dataSource = UICollectionViewDiffableDataSource<ScheduleSection, Schedule>(collectionView: scheduleCollectionView) { collectionView, indexPath, schedule in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ScheduleCollectionViewCell.reuseIdentifier,
                for: indexPath) as? ScheduleCollectionViewCell else { return UICollectionViewCell() }
            let section = ScheduleSection(rawValue: indexPath.section) ?? .done
            cell.setUpContents(section: section,
                               schedule: schedule)
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

    // MARK: - Long Press Action

    @objc
    private func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        guard gestureRecognizer.state == .began else { return }

        let point = gestureRecognizer.location(in: scheduleCollectionView)
        if let indexPath = scheduleCollectionView.indexPathForItem(at: point) {
            let alert = UIAlertController(title: "삭제하시겠습니까?", message: nil, preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
                if let schedule = self.scheduleCollectionViewDataSource.itemIdentifier(for: indexPath) {
                    self.viewModel.deleteActionDone(schedule: schedule)
                }
            }
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            present(alert, animated: true)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension ScheduleListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == calendarCollectionView {
            if let date = calendarCollectionViewDataSource.itemIdentifier(for: indexPath) {
                viewModel.dateCellSelected(date: date)
            }
        }
    }
}

// MARK: - CollectionView Sections

extension ScheduleListViewController {

    enum CalendarSection: Int, CaseIterable {
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
            let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
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
