//
//  ScheduleInfoViewController.swift
//  PersonalScheduler
//
//  Created by Dragon on 23/02/07.
//

import UIKit

class ScheduleInfoViewController: UIViewController {
    let mode: ManageMode = .create

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView(mode)
    }
    
    private func configureView(_ mode: ManageMode) {
        view = ScheduleInfoView()
        view.backgroundColor = .systemBackground
        
        switch mode {
        case .create, .edit:
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "저장",
                style: .done,
                target: self,
                action: #selector(tapRightBarButtonSaveAction)
            )
        case .read:
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "수정",
                style: .done,
                target: self,
                action: #selector(tapRightBarButtonEditAction)
            )
        }
    }
    
    @objc
    private func tapRightBarButtonSaveAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func tapRightBarButtonEditAction() {
        
    }
}
