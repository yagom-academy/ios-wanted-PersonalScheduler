//
//  ScheduleModel.swift
//  PersonalScheduler
//
//  Created by unchain on 2023/01/11.
//

import Foundation
import FirebaseFirestore

struct DataBaseDocument {
    let document: UUID
}

struct ScheduleModel {
    let documentId: String?
    let title: String?
    let startDate: String?
    let mainText: String?

    init?(firebase: [String:Any]) {
        self.documentId = firebase["documentId"] as? String
        self.title = firebase["title"] as? String
        self.startDate = firebase["startedTime"] as? String
        self.mainText = firebase["mainBody"] as? String
    }

    init(documentId: String, title: String, startDate: String, mainText: String) {
        self.documentId = documentId
        self.title = title
        self.startDate = startDate
        self.mainText = mainText
        }
}

extension ScheduleModel {
    static func build(from documents: [QueryDocumentSnapshot]) -> [ScheduleModel] {
        var schedules = [ScheduleModel]()
        for document in documents {
            schedules.append(ScheduleModel(documentId: document["documentId"] as? String ?? "",
                                           title: document["title"] as? String ?? "",
                                           startDate: document["startedTime"] as? String ?? "",
                                           mainText: document["mainBody"] as? String ?? ""))
        }
        return schedules
    }
}
