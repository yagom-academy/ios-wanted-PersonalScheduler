//
//  ScheduleManager.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/11.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ScheduleManager {
    static let shared = ScheduleManager()
    private let db = Firestore.firestore()
    
    func addSchedule(schedule: Schedule, executionError: @escaping (Error?) -> Void) {
        UserManager.shared.getCurrentUserUid() { [weak self] uid, err in
            if let err {
                executionError(err)
            } else {
                do {
                    _ = try self?.db.collection(Collection.user.rawValue).document(uid).collection(Collection.scheduleList.rawValue)
                        .addDocument(from: schedule) { addError in
                            if let addError {
                                executionError(addError)
                            } else {
                                executionError(nil)
                            }
                        }
                } catch {
                    executionError(error)
                }
            }
        }
    }
    
    func fetchScheduleListData(completion: @escaping ([Schedule]?, Error?) -> Void) {
        UserManager.shared.getCurrentUserUid() { [weak self] uid, err in
            if let err {
                completion(nil, err)
            } else {
                self?.db.collection(Collection.user.rawValue).document(uid).collection(Collection.scheduleList.rawValue)
                    .getDocuments(completion: { querySnapShot, error in
                        if let error {
                            completion(nil, error)
                        } else {
                            if let snapShot = querySnapShot {
                                var scheduleList: [Schedule] = []
                                for document in snapShot.documents {
                                    do {
                                        var schedule = try document.data(as: Schedule.self)
                                        schedule.uid = document.documentID
                                        scheduleList.append(schedule)
                                    } catch {
                                        completion(nil, error)
                                    }
                                }
                                completion(scheduleList, nil)
                            }
                        }
                    })
            }
        }
    }
    
    func deleteSchedule(scheduleUid: String, _ error: @escaping (Error?) -> Void) {
        UserManager.shared.getCurrentUserUid() { [weak self] uid, err in
            if let err {
                error(err)
            } else {
                self?.db.collection(Collection.user.rawValue).document(uid).collection(Collection.scheduleList.rawValue)
                    .document(scheduleUid).delete() { deleteError in
                        if let deleteError {
                            error(deleteError)
                        } else {
                            error(nil)
                        }
                    }
            }
        }
    }
}
