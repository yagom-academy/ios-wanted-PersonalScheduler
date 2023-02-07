//
//  ScheduleEntity.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/07.
//

import Foundation

import FirebaseFirestore
import FirebaseFirestoreSwift

struct ScheduleEntity: Codable {
    let documentID: String
    let title: String
    let startDate: Timestamp
    let endDate: Timestamp
    let description: String
    
    init(documentID: String, title: String, startDate: Date, endDate: Date?, description: String) {
        self.documentID = documentID
        self.title = title
        self.endDate = Timestamp(date: endDate ?? startDate)
        self.startDate = Timestamp(date: startDate)
        self.description = description
    }
    
    func asDomain() -> Schedule {
        let schedule = Schedule(
            id: documentID,
            title: title,
            startDate: startDate.dateValue(),
            endDate: endDate.dateValue(),
            description: description
        )
        
        return schedule
    }
}
