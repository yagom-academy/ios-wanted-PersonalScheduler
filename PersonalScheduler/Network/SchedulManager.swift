//
//  SchedulManager.swift
//  PersonalScheduler
//
//  Created by 곽우종 on 2023/01/12.
//

import Foundation

protocol SchedulManagerAble {
    func loadSchedul(userId: String) -> Observable<Result<[Schedule],Error>?>
}

final class SchedulManager: SchedulManagerAble {
    
    var firebaseManager: FirebaseManagerable
    
    init(firebaseManager: FirebaseManagerable = FirebaseManager.shared) {
        self.firebaseManager = firebaseManager
    }
    
    func loadSchedul(userId: String) -> Observable<Result<[Schedule], Error>?> {
        let scheduleObserver = Observable<Result<[Schedule],Error>?>.init(nil)
        let schedule = Schedule(userId: userId)
        firebaseManager.readArray(schedule) { result in
            switch result {
            case .success(let scheduleArray):
                scheduleObserver.value = .success(scheduleArray)
            case .failure(let error):
                scheduleObserver.value = .failure(error)
            }
        }
        
        return scheduleObserver
    }
}

