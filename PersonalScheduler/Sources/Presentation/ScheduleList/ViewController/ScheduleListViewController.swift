//
//  ScheduleListViewController.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import UIKit
import Combine

class ScheduleListViewController: UIViewController {
    
    enum Section {
        case schedule
        
        init?(index: Int) {
            switch index {
            case 0: self = .schedule
            default: return nil
            }
        }
    }
    
    public weak var coordinator: ScheduleListCoordinatorInterface?

    private let viewModel: ScheduleListViewModel
    private var cancellables = Set<AnyCancellable>()

    private var dataSource: UICollectionViewDiffableDataSource<Section, Schedule>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        bind()
        viewModel.input.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.input.viewWillAppear()
    }
    
    init(viewModel: ScheduleListViewModel, coordinator: ScheduleListCoordinatorInterface) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showScrollToSchedule(_:)), name: .scrollToSchedule, object: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var navigationTitleView: NavigationTitleView = {
        return NavigationTitleView("2023년 1월")
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: listLayout())
        collectionView.register(ScheduleCell.self)
        collectionView.backgroundColor = .psBackground
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var addScheduleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "add")?
            .withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(didTapAddButton(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        return button
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "일정을 추가해주세요."
        label.textColor = .systemGray
        label.font = .preferredFont(for: .callout, weight: .semibold)
        return label
    }()
    
    private lazy var activityIndicator: LoadingView = {
        let activityIndicator = LoadingView(backgroundColor: .clear, alpha: 1)
        return activityIndicator
    }()
    
}

private extension ScheduleListViewController {
    
    func bind() {
        viewModel.output.schedules
            .sinkOnMainThread(receiveValue: { [weak self] schedules in
                self?.applySnapshot(schedules)
            }).store(in: &cancellables)
        
        viewModel.output.schedules
            .map { $0.isEmpty }
            .sinkOnMainThread(receiveValue: { [weak self] isEmptySchedules in
                self?.emptyLabel.isHidden = !isEmptySchedules
            }).store(in: &cancellables)
        
        viewModel.output.isLoading
            .sinkOnMainThread(receiveValue: { [weak self] isLoading in
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }).store(in: &cancellables)
        
        viewModel.output.errorMessage
            .compactMap { $0 }
            .sinkOnMainThread(receiveValue: { [weak self] message in
                self?.showAlert(message: message)
            }).store(in: &cancellables)
        
        viewModel.output.showSelectedDate
            .compactMap { $0 }
            .map { IndexPath(item: $0, section: .zero) }
            .sinkOnMainThread(receiveValue: { [weak self] indexPath in
                self?.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
                self?.navigationTitleView.update(
                    title: self?.viewModel.output.currentSchedule?.startDate.toString(.yearAndMonth) ?? Date().toString(.yearAndMonth)
                )
            }).store(in: &cancellables)
        
        viewModel.output.visibleTopSchedule
            .compactMap { $0?.startDate.toString(.yearAndMonth) }
            .removeDuplicates()
            .sinkOnMainThread(receiveValue: { [weak self] date in
                self?.navigationTitleView.update(title: date)
            }).store(in: &cancellables)
        
        viewModel.output.logout
            .filter { $0 == true}
            .sinkOnMainThread(receiveValue: { [weak self] _ in
                self?.coordinator?.finished()
            }).store(in: &cancellables)
    }
    
    func setUp() {
        setUpLayout()
        setUpNavigationBar()
        setUpDataSource()
    }
    
    func setUpLayout() {
        view.backgroundColor = .psBackground
        view.addSubviews(collectionView, addScheduleButton, emptyLabel, activityIndicator)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            addScheduleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addScheduleButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            emptyLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalTo: view.widthAnchor),
            activityIndicator.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
 
    func setUpNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navigationTitleView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapNavigationTitle(_:)))
        navigationTitleView.addGestureRecognizer(tap)
        navigationController?.addCustomBottomLine(color: .systemGray4, height: 0.3)
        let moreButton = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis.circle"),
            style: .plain,
            target: self,
            action: #selector(didTapMoreButton(_:))
        )
        navigationItem.rightBarButtonItem = moreButton
    }
    
    @objc func didTapNavigationTitle(_ gesture: UITapGestureRecognizer) {
        let date = viewModel.output.currentSchedule?.startDate ?? Date()
        showDatePickerAlert(date, type: .date) { [weak self] date in
            self?.viewModel.input.selectedDate(date)
        }
    }
    
    @objc func didTapMoreButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(
            UIAlertAction(title: "로그아웃", style: .destructive) { [weak self] _ in
                self?.viewModel.input.didTapLogout()
            }
        )
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func didTapAddButton(_ sender: UIBarButtonItem) {
        coordinator?.showCreateSchedule()
    }
    
    @objc func showScrollToSchedule(_ notification: Notification) {
        guard let scheduleID = notification.object as? String,
              let index = viewModel.output.currentSchedules.firstIndex(where: { $0.id == scheduleID })
        else {
            return
        }
        let indexPath = IndexPath(item: index, section: .zero)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
    }
    
    func setUpDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Schedule>(
            collectionView: collectionView,
            cellProvider: { [weak self] collectionView, indexPath, schedule in
                let section = Section(index: indexPath.section)
                switch section {
                case .schedule:
                    let cell = collectionView.dequeueReusableCell(ScheduleCell.self, for: indexPath)
                    cell?.setUp(schedule)
                    if let prevSchedule = self?.dataSource?.itemIdentifier(for: IndexPath(item: indexPath.item - 1, section: .zero)),
                       prevSchedule.startDate.isEqualMonth(from: schedule.startDate) == false {
                        cell?.showMonthView(schedule.startDate)
                    }
                    return cell
                    
                default: return UICollectionViewCell()
                }
            })
        collectionView.dataSource = dataSource
    }
    
    private func applySnapshot(_ schedules: [Schedule]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Schedule>()
        snapshot.appendSections([.schedule])
        snapshot.appendItems(schedules)
        dataSource?.apply(snapshot)
    }
    
    func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .psBackground
        listConfiguration.trailingSwipeActionsConfigurationProvider = makeSwipeActions
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    func makeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
        guard let indexPath = indexPath, let schedule = dataSource?.itemIdentifier(for: indexPath) else {
            return nil
        }
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, completeHandler in
            self?.viewModel.input.delete(schedule: schedule)
            completeHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}

extension ScheduleListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let schedule = dataSource?.itemIdentifier(for: indexPath) else {
            return
        }
        coordinator?.showEditSchedule(schedule)
    }
    
}

extension ScheduleListViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.minX, y: visibleRect.minY)
        if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint),
           let schedule = dataSource?.itemIdentifier(for: visibleIndexPath) {
            viewModel.input.visibleTopSchedule(schedule)
        }
    }
    
}
