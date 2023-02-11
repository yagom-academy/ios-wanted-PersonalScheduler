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

    func fetchAllScheduleData(completionHandler: @escaping (Result<[ScheduleModel], ApiError>) -> Void) {
        var scheduleModels: [ScheduleModel] = []

        collection.getDocuments { (querySnapshot, error) in
            if error != nil {
                completionHandler(.failure(.firebaseFetchError))
                return
            }

            guard let documents = querySnapshot?.documents,
                  !documents.isEmpty else {
                completionHandler(.failure(.firebaseFetchDataNilError))
                return
            }

            for document in documents {
                let data = document.data()
                guard let stringID = data["id"] as? String,
                      let id = UUID(uuidString: stringID),
                      let title = data["title"] as? String,
                      let body = data["body"] as? String,
                      let date = data["date"] as? String else {
                    completionHandler(.failure(.firebaseFetchDataWrongTypeError))
                    return
                }
                let scheduleModel = ScheduleModel(id: id, title: title, body: body, date: date)
                scheduleModels.append(scheduleModel)
            }
            completionHandler(.success(scheduleModels))
        }
    }

    func addScheduleData(_ scheduleModel: ScheduleModel) {
        collection.document("\(scheduleModel.id.uuidString)").setData(scheduleModel.dictionary)
    }

    func updateScheduleData(_ scheduleModel: ScheduleModel) {
        collection.document("\(scheduleModel.id.uuidString)").updateData(scheduleModel.dictionary)
    }

    func deleteScheduleData(_ scheduleModel: ScheduleModel) {
        collection.document("\(scheduleModel.id.uuidString)").delete()
    }
}
