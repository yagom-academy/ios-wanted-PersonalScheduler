//
//  ScheduleViewController.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import UIKit
import Combine

class ScheduleViewController: UIViewController {
    
    public weak var coordinator: ScheduleCoordinatorInterface?
    
    private let viewModel: ScheduleViewModel
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    init(viewModel: ScheduleViewModel, coordinator: ScheduleCoordinatorInterface) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
