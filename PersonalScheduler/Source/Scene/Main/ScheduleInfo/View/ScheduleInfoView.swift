//
//  ScheduleInfoView.swift
//  PersonalScheduler
//
//  Created by Dragon on 23/02/07.
//

import UIKit

class ScheduleInfoView: UIView {
    
    private enum DateType {
        case startDate
        case startTime
        
        case endDate
        case endTime
    }
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.font = .preferredFont(forTextStyle: .title3)
        textField.layer.borderColor = UIColor.label.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemBackground
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
        configureDateButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureDateButton() {
        let startTimeToolbar = UIToolbar()
        let startDateToolbar = UIToolbar()
        let endTimeToolbar = UIToolbar()
        let endDateToolbar = UIToolbar()
        let startTimeSelectButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(tapStartTimeSelectButton)
        )
        let startDateSelectButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(tapStartDateSelectButton)
        )
        let endTimeSelectButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(tapEndTimeSelectButton)
        )
        let endDateSelectButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(tapEndDateSelectButton)
        )
        let emptyButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        startTimeToolbar.sizeToFit()
        startTimeToolbar.setItems([emptyButton, startTimeSelectButton], animated: true)
        startTimeTextField.inputAccessoryView = startTimeToolbar
        startTimeTextField.inputView = timePicker
        
        startDateToolbar.sizeToFit()
        startDateToolbar.setItems([emptyButton, startDateSelectButton], animated: true)
        startDateTextField.inputAccessoryView = startDateToolbar
        startDateTextField.inputView = datePicker
        
        endTimeToolbar.sizeToFit()
        endTimeToolbar.setItems([emptyButton, endTimeSelectButton], animated: true)
        endTimeTextField.inputAccessoryView = endTimeToolbar
        endTimeTextField.inputView = timePicker
        
        endDateToolbar.sizeToFit()
        endDateToolbar.setItems([emptyButton, endDateSelectButton], animated: true)
        endDateTextField.inputAccessoryView = endDateToolbar
        endDateTextField.inputView = datePicker
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
            totalStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75),
            totalStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            totalStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
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
