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
    private var dataBase = Firestore.firestore()

    private init() { }

    func savedData(user: String, document: UUID, scheduleData: ScheduleModel) {
        dataBase.collection(user).document(document.uuidString).setData([
            "documentId" : document.uuidString,
            "title" : scheduleData.title ?? "",
            "startedTime" : scheduleData.startDate ?? "",
            "mainBody" : scheduleData.mainText ?? ""
        ])
    }

    func editData(user: String, document: String, title: String, startedTime: String, mainBody: String) {
        dataBase.collection(user).document(document).setData([
            "documentId" : document,
            "title" : title,
            "startedTime" : startedTime,
            "mainBody" : mainBody
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

    func readDocument(user: String, document: String, completion: @escaping (ScheduleModel) -> Void) {
        dataBase.collection(user).document(document).getDocument { document, error in
            if let document = document, document.exists {
                let data = ScheduleModel(firebase: document.data() ?? [:])
                completion((data ?? ScheduleModel(firebase: [:]))!)
            }
        }
    }

    func deleteData(user: String, indexPath: IndexPath, cellData: [ScheduleModel]) {
        guard let doucument = cellData[indexPath.row].documentId else { return }
        dataBase.collection(user).document(doucument).delete()
    }
}
