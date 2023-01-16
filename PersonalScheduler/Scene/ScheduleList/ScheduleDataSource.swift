//
//  ScheduleDataSource.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/12.
//

import UIKit

class ScheduleDataSource: UITableViewDiffableDataSource <MainSection, ScheduleInfo> {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
