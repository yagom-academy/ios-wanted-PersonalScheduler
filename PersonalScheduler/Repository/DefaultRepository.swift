//
//  DefaultRepository.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/07.
//

import Foundation

import FirebaseFirestore
import FirebaseFirestoreSwift

final class DefaultRepository: Repository {
    private let dataBase: Firestore
    
    init(dataBase: Firestore) {
        self.dataBase = dataBase
    }
    
    func readAll(
        from userID: String,
        completion: @escaping ((Result<[ScheduleEntity], RemoteDBError>) -> Void)
    ) {
        var scheduleList: [ScheduleEntity] = []
        let reference = dataBase.collection(userID)
        
        reference.getDocuments { snapshot, error in
            if let error {
                completion(.failure(.failedRead(error)))
                return
            }
            guard let snapshot else { return }
            
            snapshot.documents.forEach { document in
                guard let scheduleEntity = try? document.data(as: ScheduleEntity.self) else { return }
                
                scheduleList.append(scheduleEntity)
            }
            
            completion(.success(scheduleList))
        }
    }
    
    func read(
        from userID: String,
        documentID: String,
        completion: @escaping ((Result<ScheduleEntity, RemoteDBError>) -> Void)
    ) {
        let reference = dataBase.collection(userID).document(documentID)
        
        reference.getDocument(as: ScheduleEntity.self) { result in
            switch result {
            case .success(let schedule):
                completion(.success(schedule))
            case .failure(let error):
                completion(.failure(.failedRead(error)))
            }
        }
    }
    
    func create(
        from userID: String,
        at schedule: Schedule,
        completion: @escaping ((Result<Void, RemoteDBError>) -> Void)
    ) {
        let reference = dataBase.collection(userID).document()
        let scheduleEntity = ScheduleEntity(
            documentID: reference.documentID,
            title: schedule.title,
            startDate: schedule.startDate,
            endDate: schedule.endDate,
            description: schedule.description
        )
        
        do {
            try reference.setData(from: scheduleEntity)
            completion(.success(()))
        } catch let error {
            completion(.failure(.failedCreate(error)))
        }
    }
    
    func update(
        from userID: String,
        at schedule: Schedule,
        completion: @escaping ((Result<Void, RemoteDBError>) -> Void)
    ) {
        let reference = dataBase.collection(userID).document(schedule.id)
        
        reference.updateData([
            "title": schedule.title,
            "startDate": schedule.startDate,
            "endDate": schedule.endDate ?? schedule.startDate,
            "description": schedule.description
        ]) { error in
            if let error {
                completion(.failure(.failedUpdate(error)))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func delete(
        from userID: String,
        at schedule: Schedule,
        completion: @escaping ((Result<Void, RemoteDBError>) -> Void)
    ) {
        let reference = dataBase.collection(userID).document()
        
        reference.delete { error in
            if let error {
                completion(.failure(.failedDelete(error)))
            } else {
                completion(.success(()))
            }
        }
    }
}
