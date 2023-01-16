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
        let userSchedulesDocumentRefrerence = database.collection("Users/\(firebaseID)/Schedules").document(schedule.id)
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
    
    func fetchScheduleData(firebaseID: String) async -> [ScheduleDTO] {
        await withCheckedContinuation { continuation in
            var fetchedData: [ScheduleDTO] = []
            let scheduleCollection = database.collection("Users/\(firebaseID)/Schedules")
            
            scheduleCollection.getDocuments { querySnapshot, error in
                guard let querySnapshot = querySnapshot else {
                    return
                }
                
                querySnapshot.documents.forEach { document in
                    fetchedData.append(
                        ScheduleDTO(
                            id: document["id"] as? String ?? "",
                            title: document["title"] as? String ?? "",
                            description: document["description"] as? String ?? "",
                            startMoment: document["startMoment"] as? String ?? "",
                            endMoment: document["endMoment"] as? String ?? "",
                            status: document["status"] as? String ?? ""
                        )
                    )
                }

                continuation.resume(returning: fetchedData)
            }
        }
    }
    
    func updateSchedule(firebaseID: String, schedule: Schedule) {
        let scheduleDTO = schedule.toScheduleDTO()
        let scheduleCollection = database.collection("Users/\(firebaseID)/Schedules")
        scheduleCollection.document(schedule.id).updateData([
            "title": scheduleDTO.title,
            "description": scheduleDTO.description,
            "startMoment": scheduleDTO.startMoment,
            "endMoment": scheduleDTO.endMoment,
            "status": scheduleDTO.status
        ]) { error in
            guard error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
        }
    }
    
    func deleteSchedule(firebaseID: String, schedule: Schedule) {
        let scheduleCollection = database.collection("Users/\(firebaseID)/Schedules")
        scheduleCollection.document(schedule.id).delete() { error in
            guard error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
        }
    }
    
}
