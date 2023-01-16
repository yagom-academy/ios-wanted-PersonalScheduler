//
//  SchedulManager.swift
//  PersonalScheduler
//
//  Created by 우롱차 on 2023/01/12.
//

import Foundation

protocol SchedulManagerAble {
    func loadSchedule(userId: String) -> Observable<Result<[Schedule],Error>?>
    func addSchedule(schedule: Schedule) -> Observable<Result<Void, Error>?>
    func deleteSchedule(schedule: Schedule) -> Observable<Result<Void, Error>?>
}

final class SchedulManager: SchedulManagerAble {
    
    var firebaseManager: FirebaseManagerable
    
    init(firebaseManager: FirebaseManagerable = FirebaseManager.shared) {
        self.firebaseManager = firebaseManager
    }
    
    func loadSchedule(userId: String) -> Observable<Result<[Schedule], Error>?> {
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
    
    func addSchedule(schedule: Schedule) -> Observable<Result<Void, Error>?> {
        let resultObserVer = Observable<Result<Void, Error>?>.init(nil)
        do {
            try firebaseManager.create(schedule)
            resultObserVer.value = .success(())
        } catch {
            resultObserVer.value = .failure(error)
        }
        return resultObserVer
    }
    
    func deleteSchedule(schedule: Schedule) -> Observable<Result<Void, Error>?> {
        let resultObserVer = Observable<Result<Void, Error>?>.init(nil)
        do {
            try firebaseManager.delete(schedule)
            resultObserVer.value = .success(())
        } catch {
            resultObserVer.value = .failure(error)
        }
        return resultObserVer
    }
}

