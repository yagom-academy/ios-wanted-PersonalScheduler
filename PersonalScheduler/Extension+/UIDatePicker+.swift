//
//  UIDatePicker+.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 2023/02/11.
//

import UIKit

extension UIDatePicker {

    convenience init(mode: UIDatePicker.Mode = .dateAndTime, style: UIDatePickerStyle = .automatic) {
        self.init()
        self.datePickerMode = mode
        self.preferredDatePickerStyle = style
        self.contentHorizontalAlignment = .leading
        translatesAutoresizingMaskIntoConstraints = false
    }
}
