//
//  Schedule.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import Foundation

struct Schedule: Codable {
    let title: String
    let startDate: Date
    let endDate: Date
    let description: String
}
