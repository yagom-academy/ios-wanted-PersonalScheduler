//
//  UIView+extension.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
}
