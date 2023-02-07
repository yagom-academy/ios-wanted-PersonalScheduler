//
//  ScheduleEntity.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/07.
//

import Foundation

import FirebaseFirestore

struct ScheduleEntity: Codable {
    let title: String
    let startDate: Timestamp
    let endDate: Timestamp
    let description: String
    
    init(title: String, startDate: Date, endDate: Date?, description: String) {
        self.title = title
        self.startDate = Timestamp(date: startDate)
        self.description = description
        
        if let endDate {
            self.endDate = Timestamp(date: endDate)
        } else {
            self.endDate = Timestamp(date: startDate)
        }
    }
}
