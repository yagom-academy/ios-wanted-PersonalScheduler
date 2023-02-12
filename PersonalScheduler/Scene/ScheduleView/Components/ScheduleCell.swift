//
//  ScheduleCell.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/11.
//

import UIKit

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

class ScheduleCell: UITableViewCell, ReuseIdentifiable {
}
