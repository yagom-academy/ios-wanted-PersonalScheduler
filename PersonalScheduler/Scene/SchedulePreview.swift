//
//  SchedulePreview.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/12.
//

import Foundation

struct SchedulePreview: Hashable {
    let id: String
    let title: String
    let period: String
    let description: String
    let startDate: Date
    let endDate: Date
    
    var startDateString: String {
        return startDate.convertToString()
    }
}

