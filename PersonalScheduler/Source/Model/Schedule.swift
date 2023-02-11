//  PersonalScheduler - Schedule.swift
//  Created by zhilly on 2023/02/09

import Foundation

struct Schedule: Decodable, Hashable {
    var title: String
    var startingDate: Date?
    var deadline: Date?
    var body: String
}
