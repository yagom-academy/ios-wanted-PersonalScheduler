//
//  Schedule.swift
//  PersonalScheduler
//
//  Created by Judy on 2023/01/10.
//

import Foundation

struct Schedule {
    let id: UUID
    let title: String
    let content: String
    let isNotified: Bool
    let startTime: Date
    let endTime: Date
    let isAllday: Bool
}
