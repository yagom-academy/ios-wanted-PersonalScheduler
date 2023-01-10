//
//  TitleTextField.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/10.
//

import UIKit

class TitleTextField: UITextField {
    
    var cancelButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    private func setting() {
        self.layer.borderColor = UIColor.cyan.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 16.0
        self.layer.masksToBounds = true
        self.placeholder = "제목을 입력해주세요."
        // 왼쪽 여백
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        self.leftViewMode = .always
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
