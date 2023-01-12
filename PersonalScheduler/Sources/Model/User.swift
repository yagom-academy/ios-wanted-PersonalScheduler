//
//  User.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import Foundation

struct User: Codable {
    var userID: String?
    var socialType: String?
    var name: String?
    var profileURL: String?
    var schedules: [Schedule]?
}

extension User {
    
    init(_ dictinary: [String: Any]) {
        self.userID = dictinary["userID"] as? String
        self.socialType = dictinary["socialType"] as? String
        self.name = dictinary["name"] as? String
        self.profileURL = dictinary["profileURL"] as? String
        let schedules = dictinary["schedules"] as? [[String: Any]] ?? []
        self.schedules = schedules.map { Schedule($0) }
    }
    
}
