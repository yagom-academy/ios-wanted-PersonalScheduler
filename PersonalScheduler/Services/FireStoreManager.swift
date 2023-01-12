//
//  FireStoreManager.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/10.
//

import FirebaseCore
import FirebaseFirestore

protocol RemoteDataBaseProtocol {
    associatedtype T
    associatedtype U
    
    func create(_ schedule: T) async throws
    func read() async throws -> [T]
    func update(_ schedule: T, to editedSchedule: U) async throws
    func delete(_ schedule: T) async throws
}

final class FireStoreManager: RemoteDataBaseProtocol {
    typealias T = Schedule
    typealias U = ScheduleModel
    
    private let dataBase = Firestore.firestore()
    private let fireStoreCollectionId: String
    
    init(fireStoreCollectionId: String) {
        self.fireStoreCollectionId = fireStoreCollectionId
    }
    
    func create(_ schedule: Schedule) async throws {
        do {
            try await dataBase.collection(fireStoreCollectionId)
                .document(schedule.id.uuidString).setData([
                "title": schedule.title,
                "body": schedule.body,
                "startDate": schedule.startDate,
                "endDate": schedule.endDate ?? ""
            ])
            print("success create")
        } catch let error {
            print(error)
        }
    }
    
    func read() async throws -> [Schedule] {
        let querySnapshot = try await dataBase.collection(fireStoreCollectionId).getDocuments()
        var scheduleList: [Schedule] = []
        querySnapshot.documents.forEach { document in
            let data = document.data()
            let schedule = Schedule(
                id: UUID(uuidString: document.documentID) ?? UUID(),
                title: data["title"] as? String ?? "",
                body: data["body"] as? String ?? "",
                startDate: data["startDate"] as? String ?? "",
                endDate: data["endDate"] as? String ?? ""
            )
            scheduleList.append(schedule)
        }
        return scheduleList
    }
    
    func update(_ schedule: Schedule,
                to editedSchedule: ScheduleModel) async throws {
        do {
            try await dataBase.collection(fireStoreCollectionId)
                .document(schedule.id.uuidString).setData([
                "title": editedSchedule.title,
                "body": editedSchedule.body,
                "startDate": editedSchedule.startDate,
                "endDate": editedSchedule.endDate ?? ""
            ])
            print("success update")
        } catch let error {
            print(error)
        }
    }
    
    func delete(_ schedule: Schedule) async throws {
        do {
            try await dataBase.collection(fireStoreCollectionId)
                .document(schedule.id.uuidString).delete()
            print("success delete")
        } catch let error {
            print(error)
        }
    }
}
