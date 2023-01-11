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
        textField.placeholder = ScheduleInfo.Edit.titlePlaceholder
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
    
    private let allDaySwitchView = ScheduleSwitchView(text: ScheduleInfo.Edit.allDay)
    private let startDatePicker = ScheduleDatePickerView(text: ScheduleInfo.Edit.openDate)
    private let endDatePicker = ScheduleDatePickerView(text: ScheduleInfo.Edit.endDate)
    private let notificationSwitchView = ScheduleSwitchView(text: ScheduleInfo.Edit.notification)
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
    
    private func createSchedule() -> Schedule? {
        guard let title = titleTextField.text,
              let content = contentTextView.text else { return nil }
        
        guard title.isEmpty == false,
              content.isEmpty == false else {
            return nil
        }
        
        return Schedule(id: UUID(),
                        title: title,
                        content: content,
                        isNotified: notificationSwitchView.isSwitchOn,
                        startTime: startDatePicker.selectedDate,
                        endTime: endDatePicker.selectedDate)
    }
    
    private func setupView() {
        addSubView()
        setupConstraint()
        setupNavigationBar()
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
    
    private func setupNavigationBar() {
        let saveBarButton = UIBarButtonItem(title: ScheduleInfo.Edit.save,
                                            style: .done,
                                            target: self,
                                            action: #selector(saveBarButtonTapped))
        
        navigationItem.rightBarButtonItem = saveBarButton
        navigationItem.title = ScheduleInfo.newSchedule
        
    }
    
    @objc private func saveBarButtonTapped() {
        guard let newSchedule = createSchedule() else { return }

        scheduleViewModel.save(newSchedule, at: "judy")
        navigationController?.popViewController(animated: true)
    }
}


enum ScheduleInfo {
    static let newSchedule = "새로운 일정"
    static let scheduleList = "일정 목록"
    
    enum Edit {
        static let save = "저장"
        static let allDay = "하루종일"
        static let openDate = "시작"
        static let endDate = "종료"
        static let notification = "알림"
        static let titlePlaceholder = "제목을 입력해주세요."
    }
}
