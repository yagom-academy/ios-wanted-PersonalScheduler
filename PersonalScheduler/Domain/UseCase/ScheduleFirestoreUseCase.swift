//
//  ScheduleFirestoreUseCase.swift
//  PersonalScheduler
//
//  Created by Judy on 2023/01/10.
//

import FirebaseFirestore

final class ScheduleFirestoreUseCase {
    private enum ScheduleData {
        static let id = "id"
        static let title = "title"
        static let content = "content"
        static let isNotified = "isNotified"
        static let startTime = "startTime"
        static let endTime = "endTime"
        static let isAllDay = "isAllDay"
    }
    
    private let firestoreManager = FirestoreManager.shared
    
    func save(_ schedule: Schedule,
              at userID: String,
              completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        let scheduleData: [String: Any] = [
            ScheduleData.id: schedule.id.uuidString,
            ScheduleData.title: schedule.title,
            ScheduleData.content: schedule.content,
            ScheduleData.isNotified: schedule.isNotified,
            ScheduleData.startTime: schedule.startTime,
            ScheduleData.endTime: schedule.endTime,
            ScheduleData.isAllDay: schedule.isAllday
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

extension ScheduleFirestoreUseCase {
    private func toSchedule(from document: QueryDocumentSnapshot) -> Schedule? {
        guard let id = document[ScheduleData.id] as? String,
              let scheduleID =  UUID(uuidString: id),
              let title = document[ScheduleData.title] as? String,
              let content = document[ScheduleData.content] as? String,
              let isNotified = document[ScheduleData.isNotified] as? Bool,
              let startTimestamp = document[ScheduleData.startTime] as? Timestamp,
              let endTimestamp = document[ScheduleData.endTime] as? Timestamp,
              let isAllDay = document[ScheduleData.isAllDay] as? Bool else { return nil }
        
        return Schedule(id: scheduleID,
                        title: title,
                        content: content,
                        isNotified: isNotified,
                        startTime: startTimestamp.dateValue(),
                        endTime: endTimestamp.dateValue(),
                        isAllday: isAllDay)
    }
}
