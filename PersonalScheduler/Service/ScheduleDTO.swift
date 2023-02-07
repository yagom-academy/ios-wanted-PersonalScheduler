//
//  ScheduleDTO.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/07.
//

import Foundation

struct ScheduleDTO {
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
}
