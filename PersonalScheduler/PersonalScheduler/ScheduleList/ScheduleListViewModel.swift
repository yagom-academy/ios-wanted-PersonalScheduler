//
//  ScheduleListViewModel.swift
//  PersonalScheduler
//
//  Created by minsson on 2023/01/12.
//

import Foundation

@MainActor
final class ScheduleListViewModel: ObservableObject {
    
    let firebaseID: String
    
    @Published var schedules: [Schedule] = []
    
    init(firebaseID: String) {
        self.firebaseID = firebaseID
        fetchDataFromFirestore(firebaseID: firebaseID)
    }
    
    func fetchDataFromFirestore(firebaseID: String) {
        schedules.removeAll()
        
        Task {
            let fetchedData: [ScheduleDTO] = await FirebaseService.shared.fetchScheduleData(firebaseID: firebaseID)
            
            fetchedData.forEach { scheduleDTO in
                schedules.append(scheduleDTO.toEntity())
            }
        }
    }
    
    func scheduleAddingSaveButtonTapped(schedule: Schedule) {
        FirebaseService.shared.addSchedule(firebaseID: firebaseID, schedule: schedule)
    }
    
    func scheduleEditingSaveButtonTapped(schedule: Schedule) {
        FirebaseService.shared.updateSchedule(firebaseID: firebaseID, schedule: schedule)
    }
    
    func scheduleCellSwipedToLeft(schedule: Schedule) {
        FirebaseService.shared.deleteSchedule(firebaseID: firebaseID, schedule: schedule)
    }
}
