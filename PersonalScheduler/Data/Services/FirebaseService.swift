//
//  FirebaseService.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/12.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

final class FirebaseService {

    static let shared = FirebaseService()
    private let database = Firestore.firestore()
    private lazy var scheduleReference = database.collection("schedule")

    private init() { }

    func fetchSchedules(for date: Date, completion: @escaping (Result<[ScheduleDTO], Error>) -> Void) {
        guard let uid = UserDefaults.standard.string(forKey: "uid") else { return }
        scheduleReference.whereField("uid", isEqualTo: uid)
            .order(by: "startDate", descending: true)
            .order(by: "endDate", descending: false)
            .getDocuments { snapShot, error in
                guard error == nil else {
                    completion(.failure(FirebaseError.internalError))
                    return
                }
                guard let snapShot = snapShot else {
                    completion(.failure(FirebaseError.noData))
                    return
                }

                let data = snapShot.documents.compactMap {
                    ScheduleDTO(scheduleData: $0.data())
                }
                completion(.success(data))
            }
    }

    func deleteSchedule(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        scheduleReference.document(id).delete() { error in
            guard error == nil else {
                completion(.failure(FirebaseError.internalError))
                return
            }
            completion(.success(()))
        }
    }

    func saveSchedule(schedule: Schedule, completion: @escaping (Result<Void, Error>) -> Void) {
        var data = schedule.toDTO().scheduleData

        guard let id = data["scheduleId"] as? String else { return }
        scheduleReference.document(id).setData(data) { error in
            guard error == nil else {
                completion(.failure(FirebaseError.internalError))
                return
            }
            completion(.success(()))
        }
    }
}
