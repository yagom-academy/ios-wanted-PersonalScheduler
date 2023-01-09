//
//  ScheduleListViewController.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

import UIKit

final class ScheduleListViewController: UIViewController {
    private let viewModel: ScheduleListViewModel
    
    init(with viewModel: ScheduleListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
    }
    
    private func setupInitialView() {
        view.backgroundColor = .systemBackground
    }
}
