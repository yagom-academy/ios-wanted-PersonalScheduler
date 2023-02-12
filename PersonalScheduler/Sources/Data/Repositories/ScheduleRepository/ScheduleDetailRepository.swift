//
//  ScheduleDetailRepository.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

final class ScheduleDetailRepository {
    var dataBase: CollectionReference
    
    init(dataBaseName: String) {
        self.dataBase = Firestore.firestore().collection(dataBaseName)
    }
    
    func readData(documentName: String) -> AnyPublisher<Schedule?, Error> {
        return dataBase.document(documentName).toAnyPublisher()
    }
    
    func writeData(documentName: String? = nil, item: Schedule, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let _ = try? createDocument(documentName: documentName).setData(from: item) else {
            completion(.failure(StoreError.writeError))
            return
        }
        
        completion(.success(()))
    }
    
    private func createDocument(documentName: String?) -> DocumentReference {
        if let documentName = documentName {
            return dataBase.document(documentName)
        } else {
            return dataBase.document()
        }
    }
}
