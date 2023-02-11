//  PersonalScheduler - ReusableView.swift
//  Created by zhilly on 2023/02/09

import UIKit

protocol ReusableView: UIView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
