//
//  User.swift
//  PersonalScheduler
//
//  Created by bard on 2023/01/13.
//

import Foundation

struct User: Codable {
    let email: String
    let scehdule: [Schedule]
    
    var dictionary: [String: Any] {
        return [
            "email": email,
            "scehduleList": scehdule
        ]
    }
}
