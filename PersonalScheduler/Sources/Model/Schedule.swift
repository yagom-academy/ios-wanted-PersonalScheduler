//
//  Schedule.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import Foundation

struct Schedule: Codable {
    let id: String
    let title: String
    let startDate: Date
    let endDate: Date
    let description: String
}

extension Schedule {
    
    init(title: String, startDate: Date, endDate: Date, description: String) {
        self.id = UUID().uuidString
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.description = description
    }
    
}

extension Schedule: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
