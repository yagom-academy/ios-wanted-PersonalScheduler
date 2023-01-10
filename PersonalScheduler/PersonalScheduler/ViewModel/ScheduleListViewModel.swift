//
//  ScheduleListViewModel.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/10.
//

import Foundation

final class ScheduleListViewModel: ObservableObject {
    
    private let firebaseStorageManager = FirebaseStorageManager()
    private let firebaseLoginManager = FirebaseLoginManager()
    private let kakaoLoginManager = KakaoLoginManager()
    
    @Published var lists = [ScheduleList]()
    
    func fetchFirebaseStore(uid: String) {
        firebaseStorageManager.fetchScheduleList(accountUID: uid) { data in
            self.lists = data
        }
    }
    
    func logout() {
        firebaseLoginManager.handleLogout()
        
        Task {
            await kakaoLoginManager.handleLogout()
        }
    }
}
