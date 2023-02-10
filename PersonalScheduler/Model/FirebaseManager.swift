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

    func fetchAllData(completionHandler: @escaping ([ScheduleModel]) -> Void) {
        var scheduleModels: [ScheduleModel] = []

        collection.getDocuments { (querySnapshot, error) in
            if let error = error {
                // 에러처리
                print(error)
                return
            }

            guard let documents = querySnapshot?.documents,
                  !documents.isEmpty else {
                // 에러처리
                return
            }

            for document in documents {
                let data = document.data()
                guard let stringID = data["id"] as? String,
                      let id = UUID(uuidString: stringID),
                      let title = data["title"] as? String,
                      let body = data["body"] as? String,
                      let date = data["date"] as? String else {
                    // 에러처리
                    return
                }
                let scheduleModel = ScheduleModel(id: id , title: title, body: body, date: date)
                scheduleModels.append(scheduleModel)
            }
            completionHandler(scheduleModels)
        }
    }
}
