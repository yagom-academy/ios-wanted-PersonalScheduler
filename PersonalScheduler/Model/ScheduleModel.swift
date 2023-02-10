//
//  ScheduleModel.swift
//  PersonalScheduler
//
//  Created by Mangdi on 2023/02/09.
//

import Foundation

struct ScheduleModel: Identifiable {
    let id: UUID
    var title, body, date: String

    init(id: UUID = UUID(), title: String, body: String, date: String) {
        self.id = id
        self.title = title
        self.body = body
        self.date = date
    }

    var dictionary: [String: Any] {
        return [
            "id": id.uuidString,
            "title": title,
            "body": body,
            "date": date
        ]
    }
}

extension ScheduleModel {
    static var scheduleList: [ScheduleModel] = [
//        ScheduleModel(title: "헬스장 가기1", body: "유산소30분 근력30분", date: "2023.02.20"),
//        ScheduleModel(title: "헬스장 가기2", body: "유산소30분 근력30분", date: "2023.02.23"),
//        ScheduleModel(title: "헬스장 가기3", body: "유산소30분 근력30분", date: "2023.02.22"),
//        ScheduleModel(title: "헬스장 가기4", body: "유산소30분 근력30분", date: "2023.02.22"),
//        ScheduleModel(title: "헬스장 가기5", body: "유산소30분 근력30분", date: "2023.02.05")
    ]
}
