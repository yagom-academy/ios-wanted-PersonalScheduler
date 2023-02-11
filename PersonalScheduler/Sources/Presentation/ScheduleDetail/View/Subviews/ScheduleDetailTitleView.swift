//
//  ScheduleDetailTitleView.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.
        
import UIKit

final class ScheduleDetailTitleView: NavigationBar {
    private let titleTextField: ScheduleTextField = {
        let textField = ScheduleTextField()
        textField.placeholder = "할일의 제목을 입력해주세요."
        return textField
    }()
    
    private let startDateButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작일시", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitleColor(UIColor(named: "textColor"), for: .normal)
        let image = UIImage(named: "startFlag")
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        button.contentHorizontalAlignment = .leading
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.borderColor = UIColor(named: "textFieldBorderColor")?.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8.5
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowRadius = 3
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 1.0
        button.layer.masksToBounds = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let endDateButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작일시", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        let image = UIImage(named: "startFlag")
        button.setTitleColor(UIColor(named: "textColor"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        button.contentHorizontalAlignment = .leading
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.borderColor = UIColor(named: "textFieldBorderColor")?.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8.5
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowRadius = 3
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 1.0
        button.layer.masksToBounds = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(title: String) {
        super.init(title: title)
        translatesAutoresizingMaskIntoConstraints = false
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        super.configureUI()
        
        [titleTextField, startDateButton, endDateButton].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleTextField.topAnchor.constraint(equalTo: super.navigationTitleLabel.bottomAnchor, constant: 24),
            titleTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            startDateButton.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            startDateButton.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
            startDateButton.trailingAnchor.constraint(equalTo: titleTextField.centerXAnchor, constant: -8),
            startDateButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -34),
            
            endDateButton.leadingAnchor.constraint(equalTo: titleTextField.centerXAnchor, constant: 8),
            endDateButton.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
            endDateButton.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            endDateButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -34)
        ])
        
        titleTextField.setContentHuggingPriority(.required, for: .vertical)
    }
}
