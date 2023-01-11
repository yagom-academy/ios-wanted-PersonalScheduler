//
//  ScheduleAddViewModel.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/11.
//

import Foundation

final class ScheduleAddViewModel: ObservableObject {
    
    enum ButtonAlert {
        case postCheck
    }
    
    @Published var buttonAlert: ButtonAlert = .postCheck

    private let firebaseStorageManager = FirebaseStorageManager()
    private let notiManager = NotificationManager.instance

    func postSchedule(uid: String, title: String, description: String, startTimeStamp: Date, endTimeStamp: Date) {
        firebaseStorageManager.uploadPost(
            accountUID: uid,
            title: title,
            description: description,
            startTimeStamp: startTimeStamp,
            endTimeStamp: endTimeStamp
        )
        notiManager.scheduleNotification(uuid: uid, title: title, subtitle: description, Date: endTimeStamp)
    }
    
    func editSchedule(uid: String, uuid: String, title: String, description: String, startTimeStamp: Date, endTimeStamp: Date) {
        firebaseStorageManager.updateScheduleList(
            accountUID: uid,
            uuid: uuid,
            title: title,
            description: description,
            startTimeStamp: startTimeStamp,
            endTimeStamp: endTimeStamp
        )
        notiManager.cancelNotification(uid: uid)
        notiManager.scheduleNotification(uuid: uid, title: title, subtitle: description, Date: endTimeStamp)
    }
}
