//
//  ScheduleViewController.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import UIKit
import Combine

class ScheduleViewController: UIViewController {
    
    enum ViewType {
        case create
        case edit
    }
    
    private let type: ViewType
    public weak var coordinator: ScheduleCoordinatorInterface?
    
    private let viewModel: ScheduleViewModel
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    init(viewModel: ScheduleViewModel, coordinator: ScheduleCoordinatorInterface, type: ViewType) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.type = type
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension ScheduleViewController {
    
    func setUp() {
        setUpLayout()
        setUpNavigationBar()
    }
    
    func setUpLayout() {
        view.backgroundColor = .psBackground
    }
 
    func setUpNavigationBar() {
        let saveButton = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(didTapSaveButton(_:)))
        let cancelButton = UIBarButtonItem(
            image: UIImage(systemName: type == .create ? "xmark" : "chevron.backward"),
            style: .plain,
            target: self,
            action: #selector(didTapCancelButton(_:))
        )
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
        navigationController?.addCustomBottomLine(color: .systemGray4, height: 0.3)
    }
    
    @objc func didTapSaveButton(_ gesture: UIBarButtonItem) {
        print(#function)
    }
    
    @objc func didTapCancelButton(_ gesture: UIBarButtonItem) {
        coordinator?.dismiss()
    }
    
}
