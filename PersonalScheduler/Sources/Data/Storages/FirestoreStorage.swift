//
//  FirestoreStorage.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol FirestoreStorageService {
    
    func read(userID: String?) -> AnyPublisher<User, Error>
    func write(user: User) -> AnyPublisher<Bool, Error>
    func delete(user: User)
    func update(user: User) -> AnyPublisher<Bool, Error>
    
}

final class FirestoreStorage: FirestoreStorageService {
    
    static let shared = FirestoreStorage()
    private init() {}
    
    private let database = Firestore.firestore()
    
    func read(userID: String?) -> AnyPublisher<User, Error>  {
        let completed = PassthroughSubject<User, Error>()
        guard let userID else {
            return Empty().eraseToAnyPublisher()
        }
        database.collection("User")
            .document(userID)
            .getDocument { querySnapShot, error in
            if let error {
                completed.send(completion: .failure(error))
            } else {
                guard let querySnapShot, querySnapShot.data() != nil else {
                    completed.send(completion: .finished)
                    return
                }
                do {
                    let user = try querySnapShot.data(as: User.self, decoder: Firestore.Decoder())
                    completed.send(user)
                    completed.send(completion: .finished)
                } catch {
                    completed.send(completion: .failure(error))
                }
            }
        }
        return completed.eraseToAnyPublisher()
    }
    
    func write(user: User) -> AnyPublisher<Bool, Error> {
        let completed = PassthroughSubject<Bool, Error>()
        guard let userID = user.userID, let user = try? user.asFirestoreDictionary() else {
            return Empty().eraseToAnyPublisher()
        }
        database.collection("User")
            .document(userID)
            .setData(user) { error in
                if let error {
                    completed.send(false)
                    completed.send(completion: .failure(error))
                } else {
                    completed.send(true)
                    completed.send(completion: .finished)
                }
            }
        return completed.eraseToAnyPublisher()
    }
    
    func delete(user: User) {
        guard let userID = user.userID else {
            return
        }
        database.collection("User").document(userID).delete()
    }
    
    func update(user: User) -> AnyPublisher<Bool, Error> {
        let completed = PassthroughSubject<Bool, Error>()
        guard let userID = user.userID, let user = try? user.asFirestoreDictionary() else {
            return Empty().eraseToAnyPublisher()
        }
        database.collection("User")
            .document(userID)
            .setData(user, merge: true) { error in
                if let error {
                    completed.send(false)
                    completed.send(completion: .failure(error))
                } else {
                    completed.send(true)
                    completed.send(completion: .finished)
                }
            }
        return completed.eraseToAnyPublisher()
    }
}
