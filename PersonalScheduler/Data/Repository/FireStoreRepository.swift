//
//  FireStoreRepository.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/12.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

final class FireStoreRepository {
    
    private let firebaseStorage = FirebaseStorage.shared
    private let collectionString = "User"
    
    init() {
    }
    
    func fetchScheduleList(userId: String) async throws -> [ScheduleInfo] {
        let queryDocument =  try await firebaseStorage.fetch(at: collectionString)

        for document in queryDocument {
            guard let user = try? document.data(as: User.self) else { continue }
            if user.userId == userId {
                return user.schedules
            }
        }
        return []
    }
    
    func addSchedule(userId: String, _ schedule: ScheduleInfo) async throws {
        let field = ["schedules": FieldValue.arrayUnion([schedule.dictionary])]
        try await firebaseStorage.updateData(field, at: collectionString, with: userId)
    }
    
    func deleteSchedule(userId: String, _ schedule: ScheduleInfo) async throws {
        let field = ["schedules": FieldValue.arrayRemove([schedule.dictionary])]
        try await firebaseStorage.updateData(field, at: collectionString, with: userId)
    }
    
    func setUserData(userId: String) async throws {
        let field = ["userId": userId]
        try await firebaseStorage.setData(field, at: collectionString, with: userId)
    }
    
}

            
