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
    
    func readAll(with userID: String, completion: @escaping ((Result<[ScheduleDTO], RepositoryError>) -> Void)) {
        var scheduleList: [ScheduleDTO] = []
        let reference = dataBase.collection(userID)
        
        reference.getDocuments { snapshot, error in
            if let error {
                completion(.failure(.notFound(error)))
                return
            }
            guard let snapshot else { return }
            
            snapshot.documents.forEach { document in
                guard let result = try? document.data(as: ScheduleEntity.self) else { return }
                
                scheduleList.append(
                    ScheduleDTO(
                        id: document.documentID,
                        title: result.title,
                        startDate: result.startDate.dateValue(),
                        endDate: result.endDate.dateValue(),
                        description: result.description
                    )
                )
            }
            
            completion(.success(scheduleList))
        }
    }
    
    func read(with userID: String, id: String, completion: @escaping ((Result<ScheduleDTO, RepositoryError>) -> Void)) {
        let reference = dataBase.collection(userID).document(id)
        
        reference.getDocument(as: ScheduleEntity.self) { result in
            switch result {
            case .success(let schedule):
                let scheduleDTO = ScheduleDTO(
                    id: reference.documentID,
                    title: schedule.title,
                    startDate: schedule.startDate.dateValue(),
                    endDate: schedule.endDate.dateValue(),
                    description: schedule.description
                )
                
                completion(.success(scheduleDTO))
            case .failure(let error):
                completion(.failure(.notFound(error)))
            }
        }
    }
    
    func create(with userID: String, schedule: ScheduleDTO, completion: @escaping ((Result<ScheduleDTO, RepositoryError>) -> Void)) {
        let reference = dataBase.collection(userID).document()
        let scheduleEntity = ScheduleEntity(
            title: schedule.title,
            startDate: schedule.startDate,
            endDate: schedule.endDate,
            description: schedule.description
        )
        
        do {
            try reference.setData(from: scheduleEntity)
            completion(.success(schedule))
        } catch let error {
            completion(.failure(.wrongGettingDocument(error)))
        }
    }
    
    func update(with userID: String, schedule: ScheduleDTO, completion: @escaping ((Result<ScheduleDTO, RepositoryError>) -> Void)) {
        let scheduleEntity = ScheduleEntity(
            title: schedule.title,
            startDate: schedule.startDate,
            endDate: schedule.endDate,
            description: schedule.description
        )
        let reference = dataBase.collection(userID).document(schedule.id)
        
        reference.updateData([
            "title": scheduleEntity.title,
            "startDate": scheduleEntity.startDate,
            "endDate": scheduleEntity.endDate,
            "description": scheduleEntity.description
        ]) { error in
            if error != nil {
                completion(.failure(.failUpdate))
            } else {
                completion(.success(schedule))
            }
        }
    }
    
    func remove(from userID: String, at: ScheduleDTO, completion: @escaping ((Result<Void, RepositoryError>) -> Void)) {
        let reference = dataBase.collection(userID).document()
        
        reference.delete { error in
            if let error {
                completion(.failure(.notFound(error)))
            } else {
                completion(.success(()))
            }
        }
    }
}
