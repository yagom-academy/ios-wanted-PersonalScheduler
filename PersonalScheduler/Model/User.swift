//
//  User.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/10.
//

import Foundation

struct User: Codable {
    var name: String
    var email: String
    var schedulList: [Schedule]?
}
