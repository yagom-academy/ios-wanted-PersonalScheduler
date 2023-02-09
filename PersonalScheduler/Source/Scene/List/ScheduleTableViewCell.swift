//
//  ScheduleTableViewCell.swift
//  PersonalScheduler
//
//  Created by parkhyo on 2023/02/10.
//

import UIKit

final class ScheduleTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ScheduleTableViewCell:Identifiable { }
