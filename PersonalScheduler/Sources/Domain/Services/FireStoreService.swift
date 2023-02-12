//
//  FireStoreService.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

enum StoreError: Error {
    case notFoundUserid
    case decodeSnapshotError
}

protocol StoreService {
    associatedtype Model: Decodable
    func readData(documentReference: String) -> AnyPublisher<Model?, Error>
}

final class FireStoreService<Model: Decodable>: StoreService {
    typealias Model = Model
    
    private let database: CollectionReference
    
    init(referenceName: String) {
        database = Firestore.firestore().collection(referenceName)
    }
    
    func readData(documentReference: String) -> AnyPublisher<Model?, Error> {
        return database.document(documentReference).toAnyPublisher()
    }
    
    func readData(documentReference: String, collectionReference: String) -> AnyPublisher<[Model]?, Error> {
        return database.document(documentReference).collection(collectionReference).toAnyPublisher()
    }
}
