//
//  UITextField +.swift
//  PersonalScheduler
//
//  Created by Dragon on 2023/02/09.
//

import UIKit.UITextField

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
