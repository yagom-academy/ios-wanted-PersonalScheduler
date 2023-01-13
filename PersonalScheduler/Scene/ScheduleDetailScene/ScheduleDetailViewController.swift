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
        textView.keyboardDismissMode = .onDrag
        textView.adjustsFontForContentSizeCategory = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let allDaySwitchView = ScheduleSwitchView(text: ScheduleInfo.Edit.allDay)
    private let startDatePicker = ScheduleDatePickerView(text: ScheduleInfo.Edit.openDate)
    private let endDatePicker = ScheduleDatePickerView(text: ScheduleInfo.Edit.endDate)
    private let notificationSwitchView = ScheduleSwitchView(text: ScheduleInfo.Edit.notification)
    private let scheduleViewModel: ScheduleViewModel
    private let viewMode: DetailViewMode
    
    init(_ viewModel: ScheduleViewModel, viewMode: DetailViewMode) {
        self.scheduleViewModel = viewModel
        self.viewMode = viewMode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNotificationObserver()
        
        switch viewMode {
        case .display(let schedule):
            setupView()
            setupScheduleInfo(with: schedule)
        case .create:
            setupView()
        }
    }
    
    private func bind() {
        scheduleViewModel.error.subscribe { [weak self] error in
            if let description = error {
                self?.showAlert(message: description)
            }
        }
    }
    
    private func createSchedule(_ id: UUID = UUID()) -> Schedule? {
        guard let title = titleTextField.text,
              let content = contentTextView.text else { return nil }
        
        guard title.isEmpty == false,
              content.isEmpty == false else {
            showAlert(title: "저장 실패",
                      message: "모든 항목을 입력해주세요.")
            return nil
        }
        
        guard startDatePicker.selectedDate <= endDatePicker.selectedDate else {
            showAlert(title: "저장 실패",
                      message: "시작 날짜가 종료 날짜보다 이후일 수 없습니다.")
            return nil
        }
        
        return Schedule(id: id,
                        title: title,
                        content: content,
                        isNotified: notificationSwitchView.isSwitchOn,
                        startTime: startDatePicker.selectedDate,
                        endTime: endDatePicker.selectedDate,
                        isAllday: allDaySwitchView.isSwitchOn)
    }
}

//MARK: Setup View
extension ScheduleDetailViewController {
    private func setupView() {
        addSubView()
        setupConstraint()
        setupNavigationBar()
        setupTextViewDelegate()
        allDaySwitchView.switchDelegate = self
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
    
    private func setupScheduleInfo(with schedule: Schedule) {
        changeEditable(false)
        
        titleTextField.text = schedule.title
        allDaySwitchView.setupSwitch(schedule.isAllday)
        startDatePicker.setupPicker(schedule.startTime)
        endDatePicker.setupPicker(schedule.endTime)
        notificationSwitchView.setupSwitch(schedule.isNotified)
        contentTextView.text = schedule.content
        
        startDatePicker.changeTimePicker(schedule.isAllday)
        endDatePicker.changeTimePicker(schedule.isAllday)
    }
    
    private func changeEditable(_ isEditable: Bool) {
        titleTextField.isEnabled = isEditable
        allDaySwitchView.changeOnOff(isEditable)
        startDatePicker.changeOnOff(isEditable)
        endDatePicker.changeOnOff(isEditable)
        notificationSwitchView.changeOnOff(isEditable)
        contentTextView.isEditable = isEditable
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

//MARK: Setup NavigationItem
extension ScheduleDetailViewController {
    private func setupNavigationBar() {
        let saveBarButton = UIBarButtonItem(title: ScheduleInfo.Edit.save,
                                            style: .done,
                                            target: self,
                                            action: #selector(saveBarButtonTapped))
        
        let editBarButton = UIBarButtonItem(title: ScheduleInfo.Edit.modify,
                                            style: .done,
                                            target: self,
                                            action: #selector(editBarButtonTapped))
        
        switch viewMode {
        case .display(let schedule):
            navigationItem.title = schedule.title
            navigationItem.rightBarButtonItem = editBarButton
        case .create:
            navigationItem.title = ScheduleInfo.newSchedule
            navigationItem.rightBarButtonItem = saveBarButton
        }
    }
    
    @objc private func saveBarButtonTapped() {
        let savedSchedule: Schedule?
        
        switch viewMode {
        case .display(let schedule):
            savedSchedule = createSchedule(schedule.id)
        case .create:
            savedSchedule = createSchedule()
        }

        guard let schedule = savedSchedule else { return }
        
        scheduleViewModel.save(schedule)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func editBarButtonTapped() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: ScheduleInfo.Edit.save,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveBarButtonTapped))
        changeEditable(true)
    }
}

//MARK: TextView Delegate
extension ScheduleDetailViewController: UITextViewDelegate {
    private func setupTextViewDelegate() {
        contentTextView.delegate = self
    }
    
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        guard textView.text.count + text.count <= 500 else {
            showAlert(message: "내용은 500자 이하만 가능합니다.")
            return false
        }
        
        return true
    }
}

//MARK: Notification
extension ScheduleDetailViewController {
    private func addNotificationObserver() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillShow),
                                       name: UIResponder.keyboardWillShowNotification,
                                       object: nil)
        
        notificationCenter.addObserver(self,
                                       selector:
                                        #selector(keyboardWillHide),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        contentTextView.contentInset.bottom = keyboardFrame.size.height
    }
    
    @objc private func keyboardWillHide() {
        contentTextView.contentInset.bottom = .zero
    }
}

extension ScheduleDetailViewController: SetAllDayDelegate {
    func allDaySwitchChange(isOn: Bool) {
        startDatePicker.changeTimePicker(isOn)
        endDatePicker.changeTimePicker(isOn)
       
        let startDate = startDatePicker.selectedDate
        let endDate = endDatePicker.selectedDate
        
        if let startAllDay = startDate.convertToString().toDate(),
           let endAllDay = startDate.convertToString().toDate() {
            startDatePicker.setupPicker(startAllDay)
            endDatePicker.setupPicker(endAllDay)
        }
    }
}
