//
//  Schedule.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/11.
//

import Foundation

struct Schedule: Hashable {
    let id: UUID
    let title: String
    let description: String
    let startDate: Date
    let endDate: Date
}
