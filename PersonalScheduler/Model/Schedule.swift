//
//  Schedul.swift
//  PersonalScheduler
//
//  Created by 우롱차 on 2023/01/12.
//

import Foundation

struct Schedule: FirebaseDatable, Hashable {
    var userId: String
    var scheduleId: String
    var title: String?
    var todoDate: String?
    var contents: String?
    
    init(userId: String, scheduleId: String = UUID().uuidString, title: String? = nil, todoDate: String? = nil, contents: String? = nil) {
        self.userId = userId
        self.scheduleId = scheduleId
        self.title = title
        self.todoDate = todoDate
        self.contents = contents
    }
    
    var detailPath: [String] {
        get {
            var array: [String] = Schedule.path
            array.append(userId)
            array.append(scheduleId)
            return array
        }
    }
    static var path = ["schedule"]
}
