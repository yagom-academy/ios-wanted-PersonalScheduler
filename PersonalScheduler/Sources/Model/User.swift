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
