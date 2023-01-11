//
//  ScheduleListViewModel.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/10.
//

import Foundation

final class ScheduleListViewModel: ObservableObject {
    
    enum ButtonAlert {
        case logout
    }
    
    private let firebaseStorageManager = FirebaseStorageManager()
    private let firebaseLoginManager = FirebaseLoginManager()
    private let kakaoLoginManager = KakaoLoginManager()
    private let notificationManager = NotificationManager.instance

    @Published var lists = [ScheduleList]()
    @Published var buttonAlert: ButtonAlert = .logout

    func fetchFirebaseStore(uid: String) {
        firebaseStorageManager.fetchScheduleList(accountUID: uid) { data in
            self.lists = data
        }
    }
    
    func delete(accountUID: String, uuid: String) {
        firebaseStorageManager.deleteScheduleList(accountUID: accountUID, uuid: uuid)
        notificationManager.cancelNotification(uid: accountUID)
    }
    
    func logout() {
        self.buttonAlert = .logout
        firebaseLoginManager.handleLogout()
        Task {
            await kakaoLoginManager.handleLogout()
        }
    }
}
