//
//  FirebaseManager.swift
//  PersonalScheduler
//
//  Created by Mangdi on 2023/02/10.
//

import Foundation
import FirebaseFirestore

final class FirebaseManager {
    static let shared: FirebaseManager = FirebaseManager()
    private init() { }

    let collection = Firestore.firestore().collection("schedule")

    func addData(scheduleModel: ScheduleModel) {
        collection.document("\(scheduleModel.id)").updateData(scheduleModel.dictionary)
    }
}
