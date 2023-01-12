//
//  ScheduleModel.swift
//  PersonalScheduler
//
//  Created by unchain on 2023/01/11.
//

import Foundation

struct ScheduleModel {
    let title: String?
    let startDate: Date?
    let mainText: String?

    init?(firebase: [String:Any]) {
        self.title = firebase["title"] as? String
        self.startDate = firebase["statedTime"] as? Date
        self.mainText = firebase["mainBody"] as? String
    }
}
