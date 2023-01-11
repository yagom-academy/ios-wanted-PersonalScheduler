//
//  UIView+Extension.swift
//  PersonalScheduler
//
//  Created by 우롱차 on 2023/01/11.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
}
