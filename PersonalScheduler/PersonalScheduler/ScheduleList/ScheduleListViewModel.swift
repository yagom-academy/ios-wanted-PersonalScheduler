//
//  ScheduleListViewModel.swift
//  PersonalScheduler
//
//  Created by minsson on 2023/01/12.
//

import Foundation

final class ScheduleListViewModel: ObservableObject {
    
    @Published var schedules: [Schedule] = [
        Schedule(id: "1", title: "title 1", description: "description1", startMoment: Date(timeIntervalSinceNow: 0), endMoment: Date(timeIntervalSinceNow: 86400), status: .planned),
        Schedule(id: "2", title: "title 2", description: "description2", startMoment: Date(timeIntervalSinceNow: 0), endMoment: Date(timeIntervalSinceNow: 86400 * 2), status: .planned),
        Schedule(id: "3", title: "title 3", description: "description3", startMoment: Date(timeIntervalSinceNow: 0), endMoment: Date(timeIntervalSinceNow: 86400 * 3), status: .planned),
        Schedule(id: "4", title: "title 4", description: "description4", startMoment: Date(timeIntervalSinceNow: 0), endMoment: Date(timeIntervalSinceNow: 86400 * 4), status: .planned),
        Schedule(id: "5", title: "title 5", description: "description5", startMoment: Date(timeIntervalSinceNow: 0), endMoment: Date(timeIntervalSinceNow: 86400 * 5), status: .planned)
    ]
    
    init() {
        fetchDataFromFirestore()
    }
    
    func fetchDataFromFirestore() {
        
    }
    
    func scheduleAddingSaveButtonTapped(schedule: Schedule) {
        FirebaseService.shared.addSchedule(firebaseID: "kk2619244495", schedule: schedule)
    }
    
}
