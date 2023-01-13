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

    func savedData(user: String, document: UUID, scheduleData: ScheduleModel) {
        dataBase.collection(user).document(document.uuidString).setData([
            "documentId" : document.uuidString,
            "title" : scheduleData.title ?? "",
            "startedTime" : scheduleData.startDate ?? "",
            "mainBody" : scheduleData.mainText ?? ""
        ])
    }

    func readData(user: String, completion: @escaping ([ScheduleModel]) -> Void) {
        dataBase.collection(user).getDocuments { schedule, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                    completion(ScheduleModel.build(from: schedule?.documents ?? []))
            }
        }
    }

    func deleteData(user: String, indexPath: IndexPath, cellData: [ScheduleModel]) {
        guard let doucument = cellData[indexPath.row].documentId else { return }
        dataBase.collection(user).document(doucument).delete()
    }
}
