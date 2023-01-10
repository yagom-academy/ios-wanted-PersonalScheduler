//
//  InputSchedulV.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/10.
//

import UIKit

class InputSchedulV: UIView, BaseView {
    
    lazy var titleTextField: TitleTextField = {
        let textField = TitleTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
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
        self.addSubview(titleTextField)
    }
}
// MARK: - Constraints
extension InputSchedulV {
    func constraints() {
        let layout = [
            titleTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            titleTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            titleTextField.heightAnchor.constraint(equalToConstant: 30)
        ]
        
        NSLayoutConstraint.activate(layout)
    }
}
