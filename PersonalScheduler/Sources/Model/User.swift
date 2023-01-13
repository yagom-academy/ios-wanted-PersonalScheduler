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
    
    init(_ dictionary: [String: Any]) {
        self.userID = dictionary["userID"] as? String
        self.socialType = dictionary["socialType"] as? String
        self.name = dictionary["name"] as? String
        self.profileURL = dictionary["profileURL"] as? String
        let schedules = dictionary["schedules"] as? [[String: Any]] ?? []
        self.schedules = schedules.map { Schedule($0) }
    }
    
}
