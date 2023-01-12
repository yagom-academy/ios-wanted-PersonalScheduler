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
    
    init() {
        self.id = UUID().uuidString
        self.title = ""
        self.startDate = Date().nearestHour()
        self.endDate = Date().nearestHour().plusHour(1)
        self.description = ""
    }
    
    init(_ dictinary: [String: Any]) {
        self.id = dictinary["id"] as? String ?? UUID().uuidString
        self.title = dictinary["title"] as? String ?? ""
        self.startDate = dictinary["startDate"] as? Date ?? Date()
        self.endDate = dictinary["endDate"] as? Date ?? Date()
        self.description = dictinary["description"] as? String ?? ""
    }
    
}

extension Schedule: Equatable, Hashable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.startDate == rhs.startDate &&
        lhs.endDate == rhs.endDate &&
        lhs.description == rhs.description
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
