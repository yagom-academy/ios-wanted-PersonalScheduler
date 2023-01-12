//
//  FireStoreRepository.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/12.
//

import Foundation

final class FireStoreScehduleRepository {
    
    private let firebaseStorage = FirebaseStorage.shared
    private let collectionString = "Schedule"
    
    init() {
    }
    
    func fetchScheduleList() async throws -> [ScheduleInfo] {
        let queryDocument =  try await firebaseStorage.fetch(at: collectionString)
        let scheduleList = queryDocument.compactMap { elements in
            try? elements.data(as: ScheduleInfo.self)
        }
        return scheduleList
    }
    
}
