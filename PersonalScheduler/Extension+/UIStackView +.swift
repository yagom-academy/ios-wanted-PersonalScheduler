//
//  UIStackView +.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 2023/02/08.
//

import UIKit

extension UIStackView {

    convenience init(axis: NSLayoutConstraint.Axis = .horizontal,
                     distribution: Distribution = .fill,
                     alignment: Alignment = .fill,
                     spacing: CGFloat = 0,
                     radius: CGFloat = .zero,
                     backgroundColor: UIColor? = .systemBackground,
                     margin: CGFloat = .zero) {
        self.init(frame: .zero)
        self.axis = axis
        self.distribution = distribution
        self.spacing = spacing
        self.alignment = alignment
        self.layer.cornerRadius = radius
        self.backgroundColor = backgroundColor
        self.layoutMargins = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        translatesAutoresizingMaskIntoConstraints = false

        if margin != .zero {
            isLayoutMarginsRelativeArrangement = true
        }
    }
}
