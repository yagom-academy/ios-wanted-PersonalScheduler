//
//  ScheduleInfoViewController.swift
//  PersonalScheduler
//
//  Created by Dragon on 23/02/07.
//

import UIKit

class ScheduleInfoViewController: UIViewController {
    
    // MARK: Internal Properties
    
    var mode: ManageMode = .create
    var delegate: DataSendable?
    
    // MARK: Private Properties

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView(mode)
    }
    
    // MARK: Private Properties
    
    private let scheduleInfoView = ScheduleInfoView()
    
    // MARK: Internal Methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: Private Methods
    
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
    
    // MARK: Action Methods
    
    @objc
    private func tapRightBarButtonSaveAction() {
        presentDataSaveAlert()
    }
    
    @objc
    private func tapRightBarButtonEditAction() {
        scheduleInfoView.checkDataAccess(mode: .edit)
    }
    
    @objc
    private func tapRightBarButtonReadAction() {
        scheduleInfoView.checkDataAccess(mode: .edit)
    }
}

// MARK: - AlertPresentable

extension ScheduleInfoViewController: AlertPresentable {
    func presentDataSaveAlert() {
        let alert = createAlert(
            title: "데이터 관리",
            message: "일정을 저장하시겠습니까?"
        )
        let firstAlertAction = createAlertAction(
            title: "저장"
        ) { [self] in
            if let data = scheduleInfoView.saveScheduleData() {
                delegate?.sendData(with: data, mode: .create)
                
                navigationController?.popViewController(animated: true)
            } else {
                presentDataEmptyErrorAlert()
            }
        }
        let secondAlertAction = createAlertAction(
            title: "취소"
        ) {}
        
        alert.addAction(firstAlertAction)
        alert.addAction(secondAlertAction)
        
        present(alert, animated: true)
    }
    
    func presentEditModeCheckingAlert() {
        let alert = createAlert(
            title: "모드 전환",
            message: "일정을 편집하시겠습니까?"
        )
        let firstAlertAction = createAlertAction(
            title: "편집"
        ) { [self] in
            if let data = scheduleInfoView.saveScheduleData() {
                delegate?.sendData(with: data, mode: .create)
            }
            
            navigationController?.popViewController(animated: true)
        }
        let secondAlertAction = createAlertAction(
            title: "취소"
        ) {}
        
        alert.addAction(firstAlertAction)
        alert.addAction(secondAlertAction)
        
        present(alert, animated: true)
    }
    
    func presentDateInputErrorAlert() {
        let alert = createAlert(
            title: "입력 오류",
            message: "종료날짜/시간을 시작날짜/시간이후로 선택해주세요."
        )
        let AlertAction = createAlertAction(
            title: "확인"
        ) {}
        
        alert.addAction(AlertAction)
        
        present(alert, animated: true)
    }
    
    func presentDataEmptyErrorAlert() {
        let alert = createAlert(
            title: "입력 오류",
            message: "날짜/시간을 입력해주세요."
        )
        let AlertAction = createAlertAction(
            title: "확인"
        ) {}
        
        alert.addAction(AlertAction)
        
        present(alert, animated: true)
    }
}
