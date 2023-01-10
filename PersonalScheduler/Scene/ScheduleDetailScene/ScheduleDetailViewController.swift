//
//  ScheduleDetailViewController.swift
//  PersonalScheduler
//
//  Created by Judy on 2023/01/10.
//

import UIKit

final class ScheduleDetailViewController: UIViewController {
    private let entireStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목을 입력해주세요."
        textField.font = .preferredFont(forTextStyle: .title3)
        textField.borderStyle = .roundedRect
        textField.adjustsFontForContentSizeCategory = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .body)
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        textView.layer.borderWidth = 2
        textView.adjustsFontForContentSizeCategory = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let allDaySwitchView = ScheduleSwitchView(text: "하루종일")
    private let startDatePicker = ScheduleDatePickerView(text: "시작")
    private let endDatePicker = ScheduleDatePickerView(text: "종료")
    private let notificationSwitchView = ScheduleSwitchView(text: "알림")
    private let scheduleViewModel: ScheduleViewModel
    
    init(_ viewModel: ScheduleViewModel) {
        self.scheduleViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        addSubView()
        setupConstraint()
        view.backgroundColor = .systemBackground
    }
    
    private func addSubView() {
        entireStackView.addArrangedSubview(titleTextField)
        entireStackView.addArrangedSubview(allDaySwitchView)
        entireStackView.addArrangedSubview(startDatePicker)
        entireStackView.addArrangedSubview(endDatePicker)
        entireStackView.addArrangedSubview(notificationSwitchView)
        entireStackView.addArrangedSubview(contentTextView)
        
        view.addSubview(entireStackView)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            entireStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                 constant: 8),
            entireStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                 constant: -8),
            entireStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                 constant: 16),
            entireStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -16)
        ])
    }
}
