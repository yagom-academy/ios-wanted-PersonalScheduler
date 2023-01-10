//
//  ScheduleFirestoreUseCase.swift
//  PersonalScheduler
//
//  Created by Judy on 2023/01/10.
//

import FirebaseFirestore

final class ReviewFirebaseUseCase {
    private let firestoreManager = FirestoreManager.shared
    
    func save(_ schedule: Schedule,
              at userID: String,
              completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        let scheduleData: [String: Any] = [
            "id": schedule.id.uuidString,
            "title": schedule.title,
            "content": schedule.content,
            "isNotified": schedule.isNotified,
            "startTime": schedule.startTime,
            "endTime": schedule.endTime
        ]

        firestoreManager.save(scheduleData,
                              at: userID,
                              with: schedule.id.uuidString,
                              completion: completion)
    }

    func fetch(at userID: String,
               completion: @escaping (Result<[Schedule], FirebaseError>) -> Void) {
        firestoreManager.fetch(at: userID) { [weak self] result in
            switch result {
            case .success(let documents):
                let schedules = documents.compactMap {
                    return self?.toSchedule(from: $0)
                }
                
                completion(.success(schedules))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func delete(_ schedule: Schedule,
                at userID: String,
                completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        firestoreManager.delete(with: schedule.id.uuidString,
                                at: userID,
                                completion: completion)
    }
}

extension ReviewFirebaseUseCase {
    private func toSchedule(from document: QueryDocumentSnapshot) -> Schedule? {
        guard let id = document["id"] as? String,
              let scheduleID =  UUID(uuidString: id),
              let title = document["title"] as? String,
              let content = document["content"] as? String,
              let isNotified = document["isNotified"] as? Bool,
              let startTimestamp = document["startTime"] as? Timestamp,
              let endTimestamp = document["endTime"] as? Timestamp else { return nil }
        
        return Schedule(id: scheduleID,
                        title: title,
                        content: content,
                        isNotified: isNotified,
                        startTime: startTimestamp.dateValue(),
                        endTime: endTimestamp.dateValue())
    }
}
