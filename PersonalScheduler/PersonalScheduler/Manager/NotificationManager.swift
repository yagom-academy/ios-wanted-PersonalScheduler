//
//  NotificationManager.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/11.
//

import UserNotifications

final class NotificationManager {
    
    static let instance = NotificationManager()
    
    private init() {}
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("SUCCESS")
            }
        }
    }
    
    func scheduleNotification(uuid: String, title: String, subtitle: String, Date: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = .default
        content.badge = 1
        
        let dateInfo = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: Date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
                                                        
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification(uuid: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [uuid])
    }
    
}
