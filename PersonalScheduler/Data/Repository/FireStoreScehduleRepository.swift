//
//  FireStoreRepository.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/12.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

final class FireStoreScehduleRepository {
    
    private let firebaseStorage = FirebaseStorage.shared
    private let collectionString = "User"
    
    init() {
    }
    
    func fetchScheduleList() async throws -> [ScheduleInfo] {
        let queryDocument =  try await firebaseStorage.fetch(at: collectionString)

        for document in queryDocument {
            guard let user = try? document.data(as: User.self) else { continue }
            if user.userId == "hoyoungId" {
                return user.schedules
            }
        }
        return []
    }
    
    func addSchedule(_ schedule: ScheduleInfo) async throws {
        let field = ["schedules": FieldValue.arrayUnion([schedule.dictionary])]
        try await firebaseStorage.update(field, at: collectionString, with: "hoyoungId")
    }
    
}

            
