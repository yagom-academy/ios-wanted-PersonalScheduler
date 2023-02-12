//
//  ScheduleDetailTitleView.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.
        
import UIKit
import Combine

protocol ScheduleDetailTitleDelegate: AnyObject {
    func scheduleDetailTitleView(with titleView: ScheduleDetailTitleView, title: String?)
    func scheduleDetailTitleView(didTapStartTime titleView: ScheduleDetailTitleView, starTime: Date)
    func scheduleDetailTitleView(didTapEndTime titleView: ScheduleDetailTitleView, endTime: Date)
}

final class ScheduleDetailTitleView: NavigationBar {
    private let titleTextField: ScheduleTextField = {
        let textField = ScheduleTextField()
        textField.placeholder = "할일의 제목을 입력해주세요."
        return textField
    }()
    
    private let startDateButton: ScheduleTextField = {
        let textField = ScheduleTextField()
        textField.placeholder = "시작 날짜"
        textField.textAlignment = .center
        return textField
    }()
    
    private let endDateButton: ScheduleTextField = {
        let textField = ScheduleTextField()
        textField.placeholder = "종료 날짜"
        textField.textAlignment = .center
        return textField
    }()
    
    private let startDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.minimumDate = Date()
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private let endDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.minimumDate = Date()
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private var cancellable = Set<AnyCancellable>()
    
    weak var delegate: ScheduleDetailTitleDelegate?
    
    override init(title: String) {
        super.init(title: title)
        translatesAutoresizingMaskIntoConstraints = false
        
        configureInputView()

        configureUI()
        bindAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        super.configureUI()
        
        [titleTextField, startDateButton, endDateButton].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            titleTextField.topAnchor.constraint(equalTo: super.navigationTitleLabel.bottomAnchor, constant: 18),
            titleTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            startDateButton.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            startDateButton.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
            startDateButton.trailingAnchor.constraint(equalTo: titleTextField.centerXAnchor, constant: -8),
            startDateButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            endDateButton.leadingAnchor.constraint(equalTo: titleTextField.centerXAnchor, constant: 8),
            endDateButton.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
            endDateButton.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            endDateButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

private extension ScheduleDetailTitleView {
    func bindAction() {
        titleTextField.textPublisher
            .compactMap { $0 }
            .sink { self.delegate?.scheduleDetailTitleView(with: self, title: $0) }
            .store(in: &cancellable)
        
        startDatePicker.dateSelectedPublisher
            .compactMap { $0 }
            .sink {
                self.startDateButton.text = $0.convertDescription()
                self.delegate?.scheduleDetailTitleView(didTapStartTime: self, starTime: $0)
            }
            .store(in: &cancellable)
        
        endDatePicker.dateSelectedPublisher
            .compactMap { $0 }
            .sink {
                self.endDateButton.text = $0.convertDescription()
                self.delegate?.scheduleDetailTitleView(didTapEndTime: self, endTime: $0)
            }
            .store(in: &cancellable)
    }
}

private extension ScheduleDetailTitleView {
    func configureToolbar() -> UIToolbar {
        let doneBotton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let toolbar = UIToolbar()
        toolbar.setItems([doneBotton], animated: true)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        return toolbar
    }
    
    func configureInputView() {
        startDateButton.inputView = startDatePicker
        endDateButton.inputView = endDatePicker
        
        startDateButton.inputAccessoryView = configureToolbar()
        endDateButton.inputAccessoryView = configureToolbar()
    }
    
    @objc private func donePressed() {
        endEditing(true)
    }
}

private extension UIButton {
    func setTitleLabel(title: String) -> UIButton {
        setTitle(title, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 14)
        setTitleColor(UIColor(named: "textColor"), for: .normal)
        return self
    }
    
    func setImage(imageName: String) -> UIButton {
        let image = UIImage(named: imageName)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        contentHorizontalAlignment = .leading
        setImage(image, for: .normal)
        return self
    }
    
    func setShadow() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 1.0
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
        layer.masksToBounds = false
        layer.shouldRasterize = true
    }
    
    func setBorder(color: UIColor?, width: CGFloat) -> UIButton {
        layer.borderColor = color?.cgColor
        layer.borderWidth = width
        return self
    }
    
    func setInitState() -> UIButton {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 12
        return self
    }
}
