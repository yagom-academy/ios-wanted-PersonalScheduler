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
    
    private let firebaseStorageManager = FirebaseStorageManager()
    private let notificationManager = NotificationManager.instance

    @Published var buttonAlert: ButtonAlert = .postCheck

    func postSchedule(accountUID: String, title: String, description: String, startTimeStamp: Date, endTimeStamp: Date) {
        let postId = UUID().uuidString
        
        firebaseStorageManager.createSchedule(
            accountUID: accountUID,
            uuid: postId,
            title: title,
            description: description,
            startTimeStamp: startTimeStamp,
            endTimeStamp: endTimeStamp
        )
        notificationManager.scheduleNotification(uuid: postId, title: title, subtitle: description, Date: endTimeStamp)
    }
    
    func editSchedule(accountUID: String, uuid: String, title: String, description: String, startTimeStamp: Date, endTimeStamp: Date) {
        firebaseStorageManager.updateSchedule(
            accountUID: accountUID,
            uuid: uuid,
            title: title,
            description: description,
            startTimeStamp: startTimeStamp,
            endTimeStamp: endTimeStamp
        )
        notificationManager.cancelNotification(uuid: uuid)
        notificationManager.scheduleNotification(uuid: uuid, title: title, subtitle: description, Date: endTimeStamp)
    }
    
}
