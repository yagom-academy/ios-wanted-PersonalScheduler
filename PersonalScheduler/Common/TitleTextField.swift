//
//  TitleTextField.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/10.
//

import UIKit

class TitleTextField: UITextField {
    
    var cancelButton: CancelButton = CancelButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    var isHiddenCancelButton: Bool = true {
        didSet {
            self.cancelButton.isHidden = isHiddenCancelButton
        }
    }
    
    var isFocus: Bool = false {
        didSet {
            if isFocus {
                self.layer.borderColor = UIColor(red: 0.0, green: 0.31, blue: 1.0, alpha: 1.0).cgColor
            } else {
                self.layer.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1).cgColor
            }
        }
    }
    
    private func setting() {
        self.backgroundColor = UIColor(red: 0.967, green: 0.969, blue: 0.971, alpha: 1)
        self.layer.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 16.0
        self.layer.masksToBounds = true
        self.placeholder = "제목을 입력해주세요."
        // 왼쪽 여백
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        self.leftViewMode = .always
        // 취소 버튼
        rightViewMode = .always
        
        let insideView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 20))
        insideView.backgroundColor = self.backgroundColor
        insideView.addSubview(cancelButton)
        
        rightView = insideView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
