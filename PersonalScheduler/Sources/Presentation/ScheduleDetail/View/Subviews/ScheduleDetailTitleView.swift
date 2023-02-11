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
        
        addSubview(titleTextField)
        
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleTextField.topAnchor.constraint(equalTo: super.navigationTitleLabel.bottomAnchor, constant: 32),
            titleTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
}
