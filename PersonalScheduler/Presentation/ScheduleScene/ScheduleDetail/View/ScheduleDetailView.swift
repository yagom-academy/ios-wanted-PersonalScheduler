//
//  ScheduleDetailView.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/11.
//

import UIKit

final class ScheduleDetailView: UIView {
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return stackView
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addLeftPadding()
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.font = UIFont.preferredFont(forTextStyle: .title1)
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    private let startStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private let startDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "시작일 :"
        return label
    }()
    
    private let startDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .compact
        datePicker.contentHorizontalAlignment = .leading
        datePicker.widthAnchor.constraint(equalToConstant: 250).isActive = true
        return datePicker
    }()
    
    private let fakeView1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(greaterThanOrEqualToConstant: 1).isActive = true
        view.heightAnchor.constraint(greaterThanOrEqualToConstant: 1).isActive = true
        view.setContentHuggingPriority(.init(100), for: .horizontal)
        return view
    }()
    
    let endDateSwitch: UISwitch = {
        let uiswitch = UISwitch()
        uiswitch.translatesAutoresizingMaskIntoConstraints = false
        return uiswitch
    }()
    
    let endStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private let endDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "종료일 :"
        return label
    }()
    
    private let endDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .compact
        datePicker.contentHorizontalAlignment = .leading
        datePicker.widthAnchor.constraint(equalToConstant: 250).isActive = true
        return datePicker
    }()
    
    private let fakeView2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(greaterThanOrEqualToConstant: 1).isActive = true
        view.heightAnchor.constraint(greaterThanOrEqualToConstant: 1).isActive = true
        view.setContentHuggingPriority(.init(100), for: .horizontal)
        return view
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.layer.borderColor = UIColor.systemGray3.cgColor
        textView.layer.borderWidth = 2
        textView.setContentHuggingPriority(UILayoutPriority(100), for: .vertical)
        return textView
    }()
    
    init() {
        super.init(frame: .zero)
        setupInitialView()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialView() {
        backgroundColor = .systemBackground
        endStackView.isHidden = true
    }
    
    func retrieveScheduleInfo() -> Schedule {
        let title = titleTextField.text ?? "제목 없음"
        return Schedule(
            id: UUID(),
            title: title,
            body: textView.text,
            startDate: DateManager.shared.convert(date: startDatePicker.date),
            endDate: endDateSwitch.isOn ? DateManager.shared.convert(date: endDatePicker.date) : nil
        )
    }
    
    func setup(with data: Schedule) {
        titleTextField.text = data.title
        textView.text = data.body
        startDatePicker.date = DateManager.shared.convert(text: data.startDate)!
        if data.endDate != "" {
            endStackView.isHidden = false
            endDateSwitch.isOn = true
            endDatePicker.date = DateManager.shared.convert(text: data.endDate!)!
        }
    }
}

private extension ScheduleDetailView {
    
    func addSubviews() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(titleTextField)
        mainStackView.addArrangedSubview(startStackView)
        
        startStackView.addArrangedSubview(startDateLabel)
        startStackView.addArrangedSubview(startDatePicker)
        startStackView.addArrangedSubview(fakeView1)
        startStackView.addArrangedSubview(endDateSwitch)
        
        mainStackView.addArrangedSubview(endStackView)
        endStackView.addArrangedSubview(endDateLabel)
        endStackView.addArrangedSubview(endDatePicker)
        endStackView.addArrangedSubview(fakeView2)
        
        mainStackView.addArrangedSubview(textView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}
