//
//  FireStore+Extension.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

extension DocumentReference {
    func toAnyPublisher<T: Decodable>() -> AnyPublisher<T?, Error> {
        let subject = CurrentValueSubject<T?, Error>(nil)
        
        let listener = addSnapshotListener { documentSnapshot, error in
            if let error = error {
                subject.send(completion: .failure(error))
                return
            }
            
            guard let documentSnapshot = documentSnapshot else {
                subject.send(completion: .failure(StoreError.decodeSnapshotError))
                return
            }
            
            guard let data = try? documentSnapshot.data(as: T.self) else {
                subject.send(completion: .failure(StoreError.decodeSnapshotError))
                return
            }
            
            subject.send(data)
        }
        
        return subject
            .handleEvents(receiveCancel: {
                listener.remove()
            })
            .eraseToAnyPublisher()
    }
}

extension CollectionReference {
    func toAnyPublisher<T: Decodable>() -> AnyPublisher<[T]?, Error> {
        let subject = CurrentValueSubject<[T]?, Error>(nil)
        
        let listener = addSnapshotListener { snapshot, error in
            if let error = error {
                subject.send(completion: .failure(error))
                return
            }
            
            guard let snapshot = snapshot else {
                subject.send(completion: .failure(StoreError.decodeSnapshotError))
                return
            }
            
            let datas = snapshot.documents.map { try? $0.data(as: T.self) }.compactMap { $0 }
            subject.send(datas)
        }
        
        return subject.handleEvents(receiveCancel: {
            listener.remove()
        })
        .eraseToAnyPublisher()
    }
}
