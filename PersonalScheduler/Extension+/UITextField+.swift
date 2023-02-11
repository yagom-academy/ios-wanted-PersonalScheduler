//
//  UIField+.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 2023/02/10.
//

import UIKit

extension UITextField {

    convenience init(font: UIFont.TextStyle = .body,
                     placeholder: String? = nil,
                     radius: CGFloat = 0,
                     backgroundColor: UIColor = .systemGray5,
                     margin: CGFloat = 5) {
        self.init(frame: .zero)
        self.font = .preferredFont(forTextStyle: font)
        self.placeholder = placeholder
        self.layer.cornerRadius = radius
        self.backgroundColor = backgroundColor
        self.layoutMargins = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }

    func addPadding(width: CGFloat) {
        let view = UIView(frame: CGRect(origin: .zero,
                                        size: CGSize(width: width, height: self.frame.height)))
        leftView = view
        rightView = view
        leftViewMode = .always
        leftViewMode = .always
    }
}
