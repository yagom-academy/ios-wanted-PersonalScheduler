//
//  ScheduleInfoView.swift
//  PersonalScheduler
//
//  Created by Dragon on 23/02/07.
//

import UIKit

class ScheduleInfoView: UIView {
    
    // MARK: Private Enumeration
    
    private enum DateType {
        case startDate
        case startTime
        case endDate
        case endTime
    }
    
    // MARK: Private Properties
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.addLeftPadding()
        textField.backgroundColor = .systemBackground
        textField.text = "일정 제목을 입력하세요."
        textField.textColor = .lightGray
        textField.font = .preferredFont(forTextStyle: .title3)
        textField.layer.borderColor = UIColor.label.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemBackground
        textView.text = "일정 내용을 입력하세요."
        textView.textColor = .lightGray
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        textView.font = .preferredFont(forTextStyle: .title3)
        textView.layer.borderColor = UIColor.label.cgColor
        textView.layer.borderWidth = 1
        return textView
    }()
    
    private let startGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "시작일자:"
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        return label
    }()
    private let startDateTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.label.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    private let startTimeTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.label.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    private let endGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "종료일자:"
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        return label
    }()
    private let endDateTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.label.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    private let endTimeTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.label.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    private let timePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko-KR")
        return datePicker
    }()
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.locale = Locale(identifier: "ko-KR")
        return datePicker
    }()
    
    private let startDateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    private let endDateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    private let dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        return stackView
    }()
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.alignment = .center
        return stackView
    }()
    
    // MARK: Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
        configureDelegate()
        configureDateButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Internal Methods
    
    func saveScheduleData() -> Schedule? {
        if let title = titleTextField.text,
           let body = bodyTextView.text,
           let startDate = startDateTextField.text,
           let startTime = startTimeTextField.text,
           let endDate = endDateTextField.text,
           let endTime = endTimeTextField.text {
            let data = Schedule(
                title: title,
                body: body,
                startDate: startDate,
                startTime: startTime,
                endDate: endDate,
                endTime: endTime
            )
            
            return data
        } else {
            // TODO: 데이터가 다 입력되지 않았음을 알리는 알림 띄우기
        }
        
        return nil
    }
    
    func checkDataAccess(mode: ManageMode) {
        switch mode {
        case .create, .edit:
            startDateTextField.isUserInteractionEnabled = true
            startTimeTextField.isUserInteractionEnabled = true
            endDateTextField.isUserInteractionEnabled = true
            endTimeTextField.isUserInteractionEnabled = true
            titleTextField.isUserInteractionEnabled = true
            bodyTextView.isUserInteractionEnabled = true
        case .read:
            startDateTextField.isUserInteractionEnabled = false
            startTimeTextField.isUserInteractionEnabled = false
            endDateTextField.isUserInteractionEnabled = false
            endTimeTextField.isUserInteractionEnabled = false
            titleTextField.isUserInteractionEnabled = false
            bodyTextView.isUserInteractionEnabled = false
        }
    }
    
    private func configureDelegate() {
        titleTextField.delegate = self
        bodyTextView.delegate = self
        
        startDateTextField.delegate = self
        startTimeTextField.delegate = self
        endDateTextField.delegate = self
        endTimeTextField.delegate = self
    }
    
    // MARK: Private Methods
    
    private func createDateButton(type: DateType, textField: UITextField, action: Selector?) {
        let toolbar = UIToolbar()
        let barButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: action
        )
        let emptyButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        toolbar.sizeToFit()
        toolbar.setItems([emptyButton, barButtonItem], animated: true)
        
        textField.inputAccessoryView = toolbar
        
        switch type {
        case .startDate, .endDate:
            textField.inputView = datePicker
        case .startTime, .endTime:
            textField.inputView = timePicker
        }
    }
    
    private func configureDateButton() {
        createDateButton(type: .startTime, textField: startTimeTextField, action: #selector(tapStartTimeSelectButton))
        createDateButton(type: .startDate, textField: startDateTextField, action: #selector(tapStartDateSelectButton))
        createDateButton(type: .endTime, textField: endTimeTextField, action: #selector(tapEndTimeSelectButton))
        createDateButton(type: .endDate, textField: endDateTextField, action: #selector(tapEndDateSelectButton))
    }
    
    private func convertDateFormatter(type: DateType) -> String {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "ko-KR")
        
        switch type {
        case .startDate, .endDate:
            formatter.dateStyle = .short
            
            return formatter.string(from: datePicker.date)
        case .startTime, .endTime:
            formatter.timeStyle = .short
            
            return formatter.string(from: timePicker.date)
        }
    }

    private func setUpStackView() {
        startDateStackView.addArrangedSubview(startGuideLabel)
        startDateStackView.addArrangedSubview(startDateTextField)
        startDateStackView.addArrangedSubview(startTimeTextField)
        
        endDateStackView.addArrangedSubview(endGuideLabel)
        endDateStackView.addArrangedSubview(endDateTextField)
        endDateStackView.addArrangedSubview(endTimeTextField)
        
        dateStackView.addArrangedSubview(startDateStackView)
        dateStackView.addArrangedSubview(endDateStackView)
        
        totalStackView.addArrangedSubview(dateStackView)
        totalStackView.addArrangedSubview(titleTextField)
        totalStackView.addArrangedSubview(bodyTextView)
    }
    
    private func configureLayout() {
        setUpStackView()
        
        addSubview(totalStackView)
        
        NSLayoutConstraint.activate([
            startGuideLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.18),
            startGuideLabel.heightAnchor.constraint(equalTo: dateStackView.heightAnchor, multiplier: 0.4),
            startDateTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            startDateTextField.heightAnchor.constraint(equalTo: dateStackView.heightAnchor, multiplier: 0.4),
            startTimeTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            startTimeTextField.heightAnchor.constraint(equalTo: dateStackView.heightAnchor, multiplier: 0.4),
            
            endGuideLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.18),
            endGuideLabel.heightAnchor.constraint(equalTo: dateStackView.heightAnchor, multiplier: 0.4),
            endDateTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            endDateTextField.heightAnchor.constraint(equalTo: dateStackView.heightAnchor, multiplier: 0.4),
            endTimeTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            endTimeTextField.heightAnchor.constraint(equalTo: dateStackView.heightAnchor, multiplier: 0.4),
            
            dateStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            dateStackView.heightAnchor.constraint(equalTo: totalStackView.heightAnchor, multiplier: 0.12),
            
            titleTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            titleTextField.heightAnchor.constraint(equalTo: totalStackView.heightAnchor, multiplier: 0.08),
            
            bodyTextView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            
            totalStackView.widthAnchor.constraint(equalTo: widthAnchor),
            totalStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            totalStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            totalStackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20)
        ])
    }
    
    // MARK: Action Methods
    
    @objc
    private func tapStartTimeSelectButton() {
        startTimeTextField.text = convertDateFormatter(type: .startTime)
        endEditing(true)
    }
    
    @objc
    private func tapStartDateSelectButton() {
        startDateTextField.text = convertDateFormatter(type: .startDate)
        endEditing(true)
    }
    
    @objc
    private func tapEndTimeSelectButton() {
        endTimeTextField.text = convertDateFormatter(type: .endTime)
        endEditing(true)
    }
    
    @objc
    private func tapEndDateSelectButton() {
        endDateTextField.text = convertDateFormatter(type: .endDate)
        endEditing(true)
    }
}

// MARK: - UITextFieldDelegate

extension ScheduleInfoView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // TextField 비활성화
        return true
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if let textCount = textField.text?.count {
            if textCount < 35 {
                return true
            }
            return false
        }
        
        return false
    }
    
    func  textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "일정 제목을 입력하세요." && textField.textColor == .lightGray {
            textField.text = nil
            textField.textColor = .label
        }
    }
}

// MARK: - UITextViewDelegate

extension ScheduleInfoView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "일정 내용을 입력하세요." && textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .label
        }
    }
}
