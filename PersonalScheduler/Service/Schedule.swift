//
//  Schedule.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/07.
//

import Foundation

struct Schedule {
    let id: String
    let title: String
    let startDate: Date
    let endDate: Date?
    let description: String
    
    init(id: String, title: String, startDate: Date, endDate: Date, description: String) {
        self.id = id
        self.title = title
        self.startDate = startDate
        self.endDate = endDate == startDate ? nil : endDate
        self.description = description
    }
    
    func convertForViewModel() -> SchedulePreview {
        let date: String
        
        if let endDate {
            date = "\(startDate.convertToString()) - \(endDate.convertToString())"
        } else {
            date = startDate.convertToString()
        }

        let schedule = SchedulePreview(
            id: id,
            title: title,
            period: date,
            description: description,
            startDate: startDate
        )
        
        return schedule
    }
}
