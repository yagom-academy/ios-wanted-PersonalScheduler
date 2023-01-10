//
//  InputSchedulVC.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/09.
//

import UIKit

class InputSchedulVC: BaseVC {
    // MARK: - View
    let inputScheduleV = InputSchedulV()
    
    override func loadView() {
        self.view = inputScheduleV
    }
    // MARK: - ViewModel
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}
// MARK: - Configure UI
extension InputSchedulVC {
    private func configureUI() {
        setTitle(title: "스케줄 추가")
    }
}
