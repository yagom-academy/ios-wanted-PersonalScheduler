//
//  UILabel+.swift
//  PersonalScheduler
//
//  Created by junho lee on 2023/02/09.
//

import UIKit

extension UILabel {
    convenience init(font: UIFont) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = font
        self.adjustsFontForContentSizeCategory = true
    }
}
