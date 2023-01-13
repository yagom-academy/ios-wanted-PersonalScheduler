//
//  ScheduleDetailViewController.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

import UIKit

final class ScheduleDetailViewController: UIViewController {
    private let scheduleDetailView = ScheduleDetailView()
    private let viewModel: ScheduleDetailViewModel
    
    init(with viewModel: ScheduleDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        setupNavigationBar()
        setupButton()
    }
    
    private func setupInitialView() {
        if let schedule = viewModel.currentSchedule {
            scheduleDetailView.setup(with: schedule)
        }
        view = scheduleDetailView
    }
    
    private func setupNavigationBar() {
        if let schedule = viewModel.currentSchedule {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "수정",
                style: .plain,
                target: self,
                action: #selector(editButtonTapped)
            )
            navigationItem.title = schedule.title
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "저장",
                style: .plain,
                target: self,
                action: #selector(saveButtonTapped)
            )
        }
    }
    
    private func setupButton() {
        scheduleDetailView.endDateSwitch.addTarget(
            self,
            action: #selector(switchTapped(_:)),
            for: .valueChanged
        )
    }
    
    private func postSuccessAlert(message: String) {
        AlertBuilder(title: "알림", message: message, preferredStyle: .alert)
            .setButton(name: "확인", style: .default) {
                _ = self.navigationController?.popViewController(animated: true)
            }.showAlert(on: self)
    }
    
    private func postFailAlert() {
        AlertBuilder(title: "경고", message: "오류로 인해 작업을 실패했습니다.", preferredStyle: .alert)
            .setButton(name: "확인", style: .default) {
                _ = self.navigationController?.popViewController(animated: true)
            }.showAlert(on: self)
    }
    
    @objc func switchTapped(_ sender: UISwitch) {
        if sender.isOn {
            UIView.animate(withDuration: 0.3, delay: 0) { [self] in
                scheduleDetailView.endStackView.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3, delay: 0) { [self] in
                scheduleDetailView.endStackView.isHidden = true
            }
        }
    }
    
    @objc private func editButtonTapped() {
        Task {
            let scheduleModel = scheduleDetailView.retrieveScheduleInfo().toCopy()
            do {
                try await viewModel.editSchedule(scheduleModel)
                self.postSuccessAlert(message: "수정 성공")
            } catch {
                self.postFailAlert()
            }
        }
    }
    
    @objc private func saveButtonTapped() {
        Task {
            let schedule = scheduleDetailView.retrieveScheduleInfo()
            do {
                try await viewModel.saveSchedule(schedule)
                self.postSuccessAlert(message: "게시 성공")
            } catch {
                self.postFailAlert()
            }
        }
    }
}
