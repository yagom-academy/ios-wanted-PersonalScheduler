//
//  ScheduleInfoView.swift
//  PersonalScheduler
//
//  Created by Dragon on 23/02/07.
//

import UIKit

final class ScheduleInfoView: UIView {
    
    // MARK: Private Enumeration
    
    private enum DateType {
        case startDate
        case startTime
        case endDate
        case endTime
    }
    
    // MARK: Private Properties
    
    private var startTimeIntervalSince1970: Double = 0
    private var endTimeIntervalSince1970: Double = 0
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.addLeftPadding()
        textField.backgroundColor = .systemBackground
        textField.textColor = .label
        textField.font = .preferredFont(forTextStyle: .title3)
        textField.layer.borderColor = UIColor.label.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemBackground
        textView.textColor = .label
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 8, bottom: 15, right: 8)
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
        textField.textColor = .label
        textField.layer.borderColor = UIColor.label.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    private let startTimeTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.textColor = .label
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
        textField.textColor = .label
        textField.layer.borderColor = UIColor.label.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    private let endTimeTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.textColor = .label
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
    
    func showScheduleData(with scheduleData: Schedule) {
        titleTextField.text = scheduleData.title
        bodyTextView.text = scheduleData.body
        startDateTextField.text = scheduleData.startDate
        startTimeTextField.text = scheduleData.startTime
        endDateTextField.text = scheduleData.endDate
        endTimeTextField.text = scheduleData.endTime
    }
    
    func saveScheduleData() -> Schedule? {
        if let title = titleTextField.text,
           let body = bodyTextView.text,
           let startDate = startDateTextField.text,
           let startTime = startTimeTextField.text,
           let endDate = endDateTextField.text,
           let endTime = endTimeTextField.text {
            let schedule = Schedule(
                title: title,
                body: body,
                startDate: startDate,
                startTime: startTime,
                endDate: endDate,
                endTime: endTime,
                startTimeInterval1970: startTimeIntervalSince1970,
                endTimeInterval1970: endTimeIntervalSince1970
            )
            
            return checkDataText(schedule: schedule)
        }
        
        return nil
    }
    
    func checkDataAccess(mode: ManageMode) {
        switch mode {
        case .create:
            configureCreateGuideText()
            configureUserInteraction(enable: true)
        case .edit:
            configureUserInteraction(enable: true)
        case .read:
            configureUserInteraction(enable: false)
        }
    }
    
    // MARK: Private Methods
    
    private func configureDelegate() {
        titleTextField.delegate = self
        bodyTextView.delegate = self
        
        startDateTextField.delegate = self
        startTimeTextField.delegate = self
        endDateTextField.delegate = self
        endTimeTextField.delegate = self
    }
    
    private func configureCreateGuideText() {
        titleTextField.text = "일정 제목을 입력하세요. (최대 35자)"
        bodyTextView.text = "일정 내용을 입력하세요. (최대 500자) \n(시작/종료일자 기입은 필수입니다.)"
        startDateTextField.text = "시작날짜"
        startTimeTextField.text = "시작시간"
        endDateTextField.text = "종료날짜"
        endTimeTextField.text = "종료시간"
        
        titleTextField.textColor = .lightGray
        bodyTextView.textColor = .lightGray
        startDateTextField.textColor = .lightGray
        startTimeTextField.textColor = .lightGray
        endDateTextField.textColor = .lightGray
        endTimeTextField.textColor = .lightGray
    }
    
    private func configureUserInteraction(enable: Bool) {
        startDateTextField.isUserInteractionEnabled = enable
        startTimeTextField.isUserInteractionEnabled = enable
        endDateTextField.isUserInteractionEnabled = enable
        endTimeTextField.isUserInteractionEnabled = enable
        titleTextField.isUserInteractionEnabled = enable
        bodyTextView.isUserInteractionEnabled = enable
    }
    
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
        case .startDate:
            startTimeIntervalSince1970 = datePicker.date.timeIntervalSince1970
            formatter.dateStyle = .short
            
            return formatter.string(from: datePicker.date)
        case .endDate:
            endTimeIntervalSince1970 = datePicker.date.timeIntervalSince1970
            formatter.dateStyle = .short
            
            return formatter.string(from: datePicker.date)
        case .startTime:
            formatter.timeStyle = .short
            
            return formatter.string(from: timePicker.date)
        case .endTime:
            formatter.timeStyle = .short
            
            return formatter.string(from: timePicker.date)
        }
    }
    
    private func checkDataText(schedule: Schedule) -> Schedule? {
        var titleText: String = String()
        var bodyText: String = String()
        
        if schedule.startDate == "시작날짜" ||
            schedule.startDate == String() ||
            schedule.startTime == "시작시간" ||
            schedule.startTime == String() ||
            schedule.endDate == "종료날짜" ||
            schedule.endDate == String() ||
            schedule.endTime == "종료시간" ||
            schedule.endTime == String() {
            return nil
        }
        
        if schedule.title == "일정 제목을 입력하세요. (최대 35자)" ||
            schedule.title == String() {
            titleText = "[일정 제목없음]"
        } else {
            titleText = schedule.title
        }
        
        if schedule.body == "일정 내용을 입력하세요. (최대 500자) \n(시작/종료일자 기입은 필수입니다.)" ||
            schedule.body == String() {
            bodyText = "[일정 내용없음]"
        } else {
            bodyText = schedule.body
        }
        
        let data = Schedule(
            title: titleText,
            body: bodyText,
            startDate: schedule.startDate,
            startTime: schedule.startTime,
            endDate: schedule.endDate,
            endTime: schedule.endTime,
            startTimeInterval1970: startTimeIntervalSince1970,
            endTimeInterval1970: endTimeIntervalSince1970
        )
        
        return data
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
        if let startDateText = startDateTextField.text,
           let endDateText = endDateTextField.text {
            if startDateText == endDateText {
                if timePicker.date.timeIntervalSince1970 > endTimeIntervalSince1970 {
                    if endTimeIntervalSince1970 == 0 {
                        startTimeTextField.text = convertDateFormatter(type: .startTime)
                        endEditing(true)
                    }
                } else if timePicker.date.timeIntervalSince1970 <= endTimeIntervalSince1970 {
                    startTimeTextField.text = convertDateFormatter(type: .startTime)
                    endEditing(true)
                }
            } else {
                startTimeTextField.text = convertDateFormatter(type: .startTime)
                endEditing(true)
            }
        }
    }
    
    @objc
    private func tapStartDateSelectButton() {
        if datePicker.date.timeIntervalSince1970 <= endTimeIntervalSince1970 {
            startDateTextField.text = convertDateFormatter(type: .startDate)
            endEditing(true)
        } else if datePicker.date.timeIntervalSince1970 > endTimeIntervalSince1970 {
            if endTimeIntervalSince1970 == 0 {
                startDateTextField.text = convertDateFormatter(type: .startDate)
                endEditing(true)
            }
        }
    }
    
    @objc
    private func tapEndTimeSelectButton() {
        if let startDateText = startDateTextField.text,
           let endDateText = endDateTextField.text {
            if startDateText == endDateText {
                if timePicker.date.timeIntervalSince1970 >= startTimeIntervalSince1970 {
                    endTimeTextField.text = convertDateFormatter(type: .endTime)
                    endEditing(true)
                }
            } else {
                endTimeTextField.text = convertDateFormatter(type: .endTime)
                endEditing(true)
            }
        }
    }
    
    @objc
    private func tapEndDateSelectButton() {
        if datePicker.date.timeIntervalSince1970 > startTimeIntervalSince1970 {
            endDateTextField.text = convertDateFormatter(type: .endDate)
            endEditing(true)
        } else if datePicker.date.timeIntervalSince1970 == startTimeIntervalSince1970 {
            if timePicker.date.timeIntervalSince1970 >= startTimeIntervalSince1970 {
                endDateTextField.text = convertDateFormatter(type: .endDate)
                endEditing(true)
            }
        }
    }
}

// MARK: - UITextFieldDelegate

extension ScheduleInfoView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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
        if textField.textColor == .lightGray {
            textField.text = nil
            textField.textColor = .label
        }
    }
}

// MARK: - UITextViewDelegate

extension ScheduleInfoView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .label
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let textViewText = textView.text else { return true }
        let newLength = textViewText.count + text.count - range.length
        
        return newLength <= 500
    }
}
