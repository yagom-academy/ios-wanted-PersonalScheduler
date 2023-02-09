//
//  FriestoreEntity.swift
//  PersonalScheduler
//
//  Created by junho lee on 2023/02/09.
//

import Foundation

protocol FirestoreEntityType: Codable {
    var document: String { get }
    var firestoreData: [String: Any] { get }
}

struct ScheduleEntity: FirestoreEntityType {
    let id: UUID
    var title: String
    var scheduleDate: Date
    var body: String

    var document: String {
        return id.uuidString
    }
    var firestoreData: [String : Any] {
        return [
            "id": id,
            "title": title,
            "scheduleDate": scheduleDate,
            "body": body
        ]
    }
}
