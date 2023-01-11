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
    
    func addShedule(schedule: Schedule, error: @escaping (Error?) -> Void) {
        if let currentUser = Auth.auth().currentUser {
            do {
                _ = try db.collection(Collection.user.rawValue).document(currentUser.uid).collection(Collection.scheduleList.rawValue)
                    .addDocument(from: schedule) { err in
                        if let err = err {
                            error(err)
                        } else {
                            error(nil)
                        }
                    }
            } catch {
                
            }
        } else {
            error(AuthError.notFoundCurrentUser)
        }
    }
}
