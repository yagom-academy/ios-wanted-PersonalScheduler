//
//  ScheduleDetailViewController.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import UIKit

final class ScheduleDetailViewController: UIViewController {
    private let titleTextField: ScheduleTextField = {
        let textField = ScheduleTextField()
        textField.placeholder = "할일의 제목을 입력해주세요."
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

private extension ScheduleDetailViewController {
    func configureUI() {
        addSafeArea()
        addChildComponents()
        setUpLayout()
    }
    
    func addSafeArea() {
        additionalSafeAreaInsets.top += 16
        additionalSafeAreaInsets.left += 16
        additionalSafeAreaInsets.bottom += 16
        additionalSafeAreaInsets.right += 16
    }
    
    func addChildComponents() {
        [
            titleTextField
        ].forEach(view.addSubview)
    }
    
    func setUpLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            titleTextField.topAnchor.constraint(equalTo: safeArea.topAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
}

#if DEBUG
import SwiftUI

struct ScheduleDetailViewPreview: PreviewProvider {
    static var previews: some View {
        ScheduleDetailViewController()
            .showPreview()
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
