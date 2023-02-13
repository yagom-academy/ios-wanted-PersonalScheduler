//
//  Schedule.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import FirebaseFirestore
import FirebaseFirestoreSwift

struct Schedule: Codable {
    var title: String
    var body: String
    var startTime: Timestamp
    var endTime: Timestamp
}

extension Schedule {
    static var baseSchedule = Schedule(title: "", body: "", startTime: Timestamp(date: Date()), endTime: Timestamp(date: Date()))
}
