//
//  ScheduleListViewController.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import UIKit
import Combine

class ScheduleListViewController: UIViewController {
    
    public weak var coordinator: ScheduleListCoordinatorInterface?
    
    private let viewModel: ScheduleListViewModel
    private var cancellables = Set<AnyCancellable>()
    
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
    
}

private extension ScheduleListViewController {
    
    func setUp() {
        setUpLayout()
        setUpNavigationBar()
    }
    
    func setUpLayout() {
        view.backgroundColor = .psBackground
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
        moreButton.tintColor = .label
        navigationItem.rightBarButtonItem = moreButton
        navigationController?.addCustomBottomLine(color: .systemGray4, height: 0.3)
    }
    
    @objc func didTapNavigationTitle(_ gesture: UITapGestureRecognizer) {
        print(#function)
    }
    
    @objc func didTapMoreButton(_ sender: UIBarButtonItem) {
        print(#function)
    }
    
}
