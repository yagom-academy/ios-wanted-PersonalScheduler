//
//  FirebaseService.swift
//  PersonalScheduler
//
//  Created by minsson on 2023/01/12.
//

import Foundation
import FirebaseFirestore

final class FirebaseService {

    static let shared = FirebaseService()
    let database = Firestore.firestore()
    var isNewUser = false
    
    private init() { }
    
    func isNewUser(firebaseID: String) async -> Bool {
        await withCheckedContinuation { continuation in
            database.collection("Users").getDocuments { querySnapshot, error in
                guard error == nil else {
                    print(error?.localizedDescription as Any)
                    return
                }

                guard let querySnapshot = querySnapshot else {
                    return
                }

                var isNewUser = true
                querySnapshot.documents.forEach { document in
                    if document.documentID == firebaseID {
                        isNewUser = false
                    }
                }
                
                if isNewUser {
                    continuation.resume(returning: true)
                } else {
                    continuation.resume(returning: false)
                }
                
            }
        }
    }
    
    
    func addUserToDatabase(firebaseID: String) {
        let userDocumentReference = database.collection("Users").document(firebaseID)
        userDocumentReference.setData(["id": firebaseID]) { error in
            guard error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
        }
    }
    
    func addSchedule(firebaseID: String, schedule: Schedule) {
        let uuid = UUID().uuidString
        let userSchedulesDocumentRefrerence = database.collection("Users/\(firebaseID)/Schedules").document(uuid)
        let scheduleDTO = schedule.toScheduleDTO()
        
        userSchedulesDocumentRefrerence.setData([
            "id": scheduleDTO.id,
            "title": scheduleDTO.title,
            "description": scheduleDTO.description,
            "startMoment": scheduleDTO.startMoment,
            "endMoment": scheduleDTO.endMoment
        ]) { error in
            guard error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
        }
    }
    
}
