//
//  ScheduleListCell.swift
//  PersonalScheduler
//
//  Created by Mangdi on 2023/02/08.
//

import UIKit

final class ScheduleListCell: UITableViewCell {

    // MARK: - Property
    static let identifier = String(describing: ScheduleListViewController.self)

    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
