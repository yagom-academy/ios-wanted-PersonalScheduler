//
//  Schedule.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import FirebaseFirestore
import FirebaseFirestoreSwift

struct Schedule {
    var title: String
    var body: String
    var startTime: Timestamp
    var endTime: Timestamp
}
