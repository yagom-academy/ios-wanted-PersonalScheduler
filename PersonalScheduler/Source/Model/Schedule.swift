//
//  Schedule.swift
//  PersonalScheduler
//
//  Created by Kyo on 2023/02/07.
//

import Foundation

struct Schedule: Hashable {
    let id: UUID
    let startDate: Date
    let endDate: Date
    let title: String
    let content: String
}
