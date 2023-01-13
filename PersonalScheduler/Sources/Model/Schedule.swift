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
    
    var isProgressing: Bool {
        return Date().contains(start: startDate, end: endDate)
    }
    
    var hasOneMoreDay: Bool {
        return startDate.toString(.yyyyMMddEEEE) != endDate.toString(.yyyyMMddEEEE)
    }
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
    
    init(_ dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? UUID().uuidString
        self.title = dictionary["title"] as? String ?? ""
        self.startDate = dictionary["startDate"] as? Date ?? Date()
        self.endDate = dictionary["endDate"] as? Date ?? Date()
        self.description = dictionary["description"] as? String ?? ""
    }
    
}

extension Schedule: Equatable, Hashable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.startDate == rhs.startDate &&
        lhs.endDate == rhs.endDate &&
        lhs.description == rhs.description &&
        lhs.isProgressing == rhs.isProgressing
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
