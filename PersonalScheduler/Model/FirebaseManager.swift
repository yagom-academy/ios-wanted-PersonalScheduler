//
//  FirebaseManager.swift
//  PersonalScheduler
//
//  Created by unchain on 2023/01/12.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

final class FirebaseManager {
    static let shared = FirebaseManager()

    private init() { }

    private var dataBase = Firestore.firestore()
    private var reference: DocumentReference? = nil
    var data: ScheduleModel = ScheduleModel(firebase: [:]) ?? ScheduleModel(firebase: [:])!

    func savedData(user: String, scheduleData: ScheduleModel) {
        reference = dataBase.collection(user).addDocument(data: [
            "title" : scheduleData.title ?? "",
            "startedTime" : scheduleData.startDate ?? Date(),
            "mainBody" : scheduleData.mainText ?? ""
        ])
    }

    func readData(user: String) {
        dataBase.collection(user).getDocuments { schedule, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                for document in schedule!.documents {
                    self.data = ScheduleModel(firebase: document.data()) ?? ScheduleModel(firebase: [:])!
                }
            }
        }
    }
}
