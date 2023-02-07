//
//  ScheduleInfoViewController.swift
//  PersonalScheduler
//
//  Created by Dragon on 23/02/07.
//

import UIKit

class ScheduleInfoViewController: UIViewController {
    let scheduleInfoView = ScheduleInfoView()
    var mode: ManageMode = .create
    var delegate: DataSendable?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView(mode)
    }
    
    private func configureView(_ mode: ManageMode) {
        view = scheduleInfoView
        view.backgroundColor = .systemBackground
        
        switch mode {
        case .create:
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "저장",
                style: .done,
                target: self,
                action: #selector(tapRightBarButtonSaveAction)
            )
        case .edit:
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "수정",
                style: .done,
                target: self,
                action: #selector(tapRightBarButtonEditAction)
            )
        case .read:
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "편집",
                style: .done,
                target: self,
                action: #selector(tapRightBarButtonReadAction)
            )
        }
    }
    
    @objc
    private func tapRightBarButtonSaveAction() {
        if let data = scheduleInfoView.saveScheduleData() {
            delegate?.sendData(with: data, mode: .create)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func tapRightBarButtonEditAction() {
        
    }
    
    @objc
    private func tapRightBarButtonReadAction() {
        let alert = createAlert(
            title: "모드전환",
            message: "프로젝트 정보를 편집하시겠습니까?"
        )
        let firstAlertAction = createAlertAction(
            title: "편집"
        ) { [self] in
            scheduleInfoView.checkDataAccess(mode: .edit)
        }
        let secondAlertAction = createAlertAction(
            title: "취소"
        ) {}
        
        alert.addAction(firstAlertAction)
        alert.addAction(secondAlertAction)
        
        present(alert, animated: true)
    }
}

extension ScheduleInfoViewController: AlertPresentable {}
