//
//  SchedulListVC.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/09.
//

import UIKit

class SchedulListVC: BaseVC {

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}
// MARK: - Configure UI
extension SchedulListVC {
    
    private func configureUI() {
        self.navigationItem.hidesBackButton = true
    }
}

