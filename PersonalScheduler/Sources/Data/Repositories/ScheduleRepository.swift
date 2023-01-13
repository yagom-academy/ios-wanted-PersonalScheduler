//
//  ScheduleRepository.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import Foundation
import Combine
import UserNotifications

protocol ScheduleRepository {
    func read() -> AnyPublisher<[Schedule], Error>
    func write(schedule: Schedule) -> AnyPublisher<Bool, Error>
    func delete(schedule: Schedule) -> AnyPublisher<Bool, Error>
    func update(schedule: Schedule) -> AnyPublisher<Bool, Error>
}

final class DefaultScheduleRepository: ScheduleRepository {
    
    private let firestoreStorage: FirestoreStorageService
    private let localStorage: LocalStorageService
    
    init(
        firestoreStorage: FirestoreStorageService = FirestoreStorage.shared,
        localStorage: LocalStorageService = UserDefaults.standard
    ) {
        self.firestoreStorage = firestoreStorage
        self.localStorage = localStorage
    }
    
    func read() -> AnyPublisher<[Schedule], Error> {
        guard let user = localStorage.getUser() else {
            return Empty().eraseToAnyPublisher()
        }
        return firestoreStorage.read(userID: user.userID)
            .map { $0.schedules?.sorted { $0.startDate < $1.startDate } ?? [] }
            .eraseToAnyPublisher()
    }
    
    func write(schedule: Schedule) -> AnyPublisher<Bool, Error> {
        guard var user = localStorage.getUser() else {
            return Empty().eraseToAnyPublisher()
        }
        var newSchedules: [Schedule] = user.schedules ?? []
        newSchedules.append(schedule)
        user.schedules = newSchedules
        localStorage.saveUser(user)
        registerNotification(schedule)
        return firestoreStorage.write(user: user)
    }
    
    func delete(schedule: Schedule) -> AnyPublisher<Bool, Error> {
        guard var user = localStorage.getUser() else {
            return Empty().eraseToAnyPublisher()
        }
        let schedules: [Schedule] = user.schedules?.filter { $0.id != schedule.id } ?? []
        user.schedules = schedules
        localStorage.saveUser(user)
        removeNotification(schedule)
        return firestoreStorage.update(user: user)
    }
    
    func update(schedule: Schedule) -> AnyPublisher<Bool, Error> {
        guard var user = localStorage.getUser(),
              let index = user.schedules?.firstIndex(where: { $0.id == schedule.id })
        else {
            return Empty().eraseToAnyPublisher()
        }
        var newSchedules: [Schedule] = user.schedules ?? []
        newSchedules[index] = schedule
        user.schedules = newSchedules
        localStorage.saveUser(user)
        registerNotification(schedule)
        return firestoreStorage.update(user: user)
    }
}

private extension DefaultScheduleRepository {
    
    func removeNotification(_ schedule: Schedule) {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [schedule.id])
    }
    
    func registerNotification(_ schedule: Schedule) {
        removeNotification(schedule)
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "[10분 후] \(schedule.title)"
        notificationContent.body = "곧 일정이 시작됩니다."
        let dateComponents = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: Date(timeIntervalSinceReferenceDate: schedule.startDate.timeIntervalSinceReferenceDate - (600))
        )
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: false
        )
        let request = UNNotificationRequest(
            identifier: schedule.id,
            content: notificationContent,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                Logger.debug(error: error, message: "Notification Error")
            }
        }
    }
    
}
