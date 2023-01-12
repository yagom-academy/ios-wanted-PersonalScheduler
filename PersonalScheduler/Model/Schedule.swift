//
//  Schedul.swift
//  PersonalScheduler
//
//  Created by 곽우종 on 2023/01/12.
//

import Foundation

struct Schedule: FirebaseDatable, Hashable {
    var userId: String
    var title: String?
    var todoDate: String?
    var contents: String?
    
    var detailPath: [String] {
        get {
            var array: [String] = Schedule.path
            array.append(userId)
            return array
        }
    }
    static var path = ["schedule"]
}
