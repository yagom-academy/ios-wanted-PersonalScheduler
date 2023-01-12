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
    private lazy var movieReviewReference = database.collection("schedule")

    private init() { }

    func fetchSchedules(of uid: String, completion: @escaping (Result<[ScheduleDTO], Error>) -> Void) {
        movieReviewReference.whereField("uid", isEqualTo: uid)
            .order(by: "", descending: true)
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
}
