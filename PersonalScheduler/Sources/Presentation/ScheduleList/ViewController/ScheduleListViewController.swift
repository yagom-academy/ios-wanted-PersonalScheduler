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
    }
    
    init(viewModel: ScheduleListViewModel, coordinator: ScheduleListCoordinatorInterface) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        
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
    
}

private extension ScheduleListViewController {
    
    func setUp() {
        setUpLayout()
        setUpNavigationBar()
        setUpDataSource()
        applySnapshot()
    }
    
    func setUpLayout() {
        view.backgroundColor = .psBackground
        view.addSubviews(collectionView, addScheduleButton)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            addScheduleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addScheduleButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
 
    func setUpNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navigationTitleView)
        let tappedLoacationView = UITapGestureRecognizer(target: self, action: #selector(didTapNavigationTitle(_:)))
        navigationTitleView.addGestureRecognizer(tappedLoacationView)
        let moreButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.up.arrow.down.circle"),
            style: .plain,
            target: self,
            action: #selector(didTapMoreButton(_:))
        )
        navigationItem.rightBarButtonItem = moreButton
        navigationController?.addCustomBottomLine(color: .systemGray4, height: 0.3)
    }
    
    @objc func didTapNavigationTitle(_ gesture: UITapGestureRecognizer) {
        print(#function)
    }
    
    @objc func didTapMoreButton(_ sender: UIBarButtonItem) {
        print(#function)
    }
    
    @objc func didTapAddButton(_ sender: UIBarButtonItem) {
        coordinator?.showCreateSchedule()
    }
    
    func setUpDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Schedule>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, schedule in
                let section = Section(index: indexPath.section)
                switch section {
                case .schedule:
                    let cell = collectionView.dequeueReusableCell(ScheduleCell.self, for: indexPath)
                    cell?.setUp(schedule)
                    return cell
                    
                default: return UICollectionViewCell()
                }
            })
        collectionView.dataSource = dataSource
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Schedule>()
        snapshot.appendSections([.schedule])
        snapshot.appendItems(Array(0...20).map { _ in
            return Schedule(
                title: "당근 거래",
                startDate: Date(),
                endDate: Date(),
                description: "공기 청정기를 살거야~~ 요즘에 공기가 너무 안좋아서 살 수 밖에 없어...."
            )
        })
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
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, completeHandeler in
            print(schedule)
            completeHandeler(true)
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
