//
//  InputSchedulV.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/10.
//

import UIKit

enum InputViewType {
    case add
    case edit(schedule: Schedule)
}

class InputScheduleV: UIView, BaseView {
    
    var saveButton: ScheduleSaveButton = ScheduleSaveButton()
    
    lazy var indicator: ActivityIndicator = {
        let activityIndicator = ActivityIndicator()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
    }()
    
    private lazy var titleGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "일정 제목"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    lazy var titleTextField: TitleTextField = {
        let textField = TitleTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isHiddenCancelButton = true
        
        return textField
    }()
    
    private lazy var titleLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "0/20"
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleGuideLabel, titleTextField, titleLengthLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .trailing
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var contentGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "일정 내용"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    lazy var contentTextField: ContentTextField = {
        let textView = ContentTextField()
        
        return textView
    }()
    
    private lazy var contentLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "0/500"
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [contentGuideLabel, contentTextField, contentLengthLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .trailing
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var startDateGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "일정 시작일"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    lazy var startDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .compact
        picker.datePickerMode = .dateAndTime
        picker.locale = Locale(identifier: "ko-KR")
        picker.timeZone = .autoupdatingCurrent
        
        return picker
    }()
    
    private lazy var startDateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [startDateGuideLabel, startDatePicker])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        
        return stackView
    }()
    
    private lazy var endDateGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "일정 종료일"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    lazy var endDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .compact
        picker.datePickerMode = .dateAndTime
        picker.locale = Locale(identifier: "ko-KR")
        picker.timeZone = .autoupdatingCurrent
        
        return picker
    }()
    
    private lazy var endDateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [endDateGuideLabel, endDatePicker])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        
        return stackView
    }()
    
    private lazy var fullStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleStackView, contentStackView,
                                                       startDateStackView, endDateStackView])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        constraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        self.addSubview(fullStackView)
        self.addSubview(indicator)
    }
    
    func setTitleLengthLabel(length: Int) {
        titleLengthLabel.text = "\(length)/20"
    }
    
    func setContentLengthLabel(length: Int) {
        contentLengthLabel.text = "\(length)/500"
    }
    
    func editViewSetting(schedule: Schedule) {
        self.saveButton.setTitle("수정하기", for: .normal)
        self.titleTextField.text = schedule.title
        self.titleTextField.isFocus = true
        setTitleLengthLabel(length: schedule.title.count)
        self.contentTextField.text = schedule.content
        self.contentTextField.isFocus = true
        self.contentTextField.textColor = .black
        setContentLengthLabel(length: schedule.content.count)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-M-d_HH:mm:ss"
        self.startDatePicker.date = dateFormatter.date(from: schedule.startDate)!
        self.endDatePicker.date = dateFormatter.date(from: schedule.endDate)!
    }
}
// MARK: - Constraints
extension InputScheduleV {
    func constraints() {
        let layout = [
            fullStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            fullStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            fullStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            titleGuideLabel.leadingAnchor.constraint(equalTo: titleStackView.leadingAnchor, constant: 10),
            titleTextField.heightAnchor.constraint(equalToConstant: 48),
            titleTextField.widthAnchor.constraint(equalTo: fullStackView.widthAnchor),
            contentGuideLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 10),
            contentTextField.heightAnchor.constraint(equalToConstant: 144),
            contentTextField.widthAnchor.constraint(equalTo: fullStackView.widthAnchor),
            startDateGuideLabel.leadingAnchor.constraint(equalTo: startDateStackView.leadingAnchor, constant: 10),
            startDatePicker.heightAnchor.constraint(equalToConstant: 48),
            startDatePicker.widthAnchor.constraint(equalTo: fullStackView.widthAnchor),
            endDateGuideLabel.leadingAnchor.constraint(equalTo: endDateStackView.leadingAnchor, constant: 10),
            endDatePicker.heightAnchor.constraint(equalToConstant: 48),
            endDatePicker.widthAnchor.constraint(equalTo: fullStackView.widthAnchor),
            indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(layout)
    }
}
