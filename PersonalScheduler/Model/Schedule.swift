//
//  Schedule.swift
//  PersonalScheduler
//
//  Created by bard on 2023/01/13.
//

struct Schedule: Codable {
    let title: String?
    let body: String
    let createDate: String
    
    var dictionary: [String: Any] {
        return [
            "title": title,
            "body": body,
            "createDate": createDate
        ]
    }
}
