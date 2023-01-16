//
//  ContentTextField.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/10.
//

import UIKit

class ContentTextField: UITextView {
    static let placeHolderText = "해야할 일을 입력해주세요."
    static let placeHolderTextColor = UIColor(red: 0.812, green: 0.812, blue: 0.812, alpha: 1)
    
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
        self.text = ContentTextField.placeHolderText
        self.textColor = ContentTextField.placeHolderTextColor
        self.font = UIFont.systemFont(ofSize: 18)
        self.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
