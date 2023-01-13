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
    private let facebookLoginManager = FacebookLoginManager()
    private let notificationManager = NotificationManager.instance

    @Published var lists = [ScheduleList]()
    @Published var buttonAlert: ButtonAlert = .logout

    func fetchFirebaseStore(accountUID: String) {
        firebaseStorageManager.readSchedule(accountUID: accountUID) { data in
            self.lists = data
        }
    }
    
    func delete(accountUID: String, uuid: String) {
        firebaseStorageManager.deleteSchedule(accountUID: accountUID, uuid: uuid)
        notificationManager.cancelNotification(uuid: uuid)
    }
    
    func logout() {
        buttonAlert = .logout
        firebaseLoginManager.handleLogout()
        facebookLoginManager.logoutFacebook()
        Task {
            await kakaoLoginManager.handleLogout()
        }
    }
    
}
