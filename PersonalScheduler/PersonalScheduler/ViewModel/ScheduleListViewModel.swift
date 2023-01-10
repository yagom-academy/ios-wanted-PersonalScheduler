//
//  ScheduleListViewModel.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/10.
//

import Foundation

final class ScheduleListViewModel: ObservableObject {
    
    let firebaseStorageManager = FirebaseStorageManager()
    @Published var lists = [ScheduleList]()
    
    init() {
        // firebaseStorageManager.uploadPost(title: "Test", description: "Test", startTimeStamp: Date(), endTimeStamp: Date())
        fetchFirebaseStore()
    }
    
    func fetchFirebaseStore() {
        firebaseStorageManager.fetchScheduleList(accountUID: "") { data in
            self.lists = data
        }
    }

}
