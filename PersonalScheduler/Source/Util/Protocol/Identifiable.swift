//
//  Identifiable.swift
//  PersonalScheduler
//
//  Created by Kyo on 2023/02/10.
//

import UIKit

protocol Identifiable where Self: UIView { }

extension Identifiable {
    static var identifier: String {
        return String(describing: self)
    }
}
