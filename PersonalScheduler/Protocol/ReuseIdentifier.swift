//
//  ReuseIdentifier.swift
//  PersonalScheduler
//
//  Created by bard on 2023/01/13.
//

import UIKit

protocol ReuseIdentifiable {
    static var identifier: String { get }
}

extension ReuseIdentifiable {
    static var identifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: ReuseIdentifiable { }
