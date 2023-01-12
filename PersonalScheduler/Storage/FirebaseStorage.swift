//
//  FirebaseStorage.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/12.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

final class FirebaseStorage {
    static let shared = FirebaseStorage()
    private let database = Firestore.firestore()
    
    private init() { }
    
    func setData(_ data: [String: Any],
              at collection: String,
              with id: String
    ) async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            database.collection(collection).document(id).setData(data) { error in
                if error != nil {
                    continuation.resume(throwing: FireBaseError.save)
                }
                continuation.resume()
            }
        }
    }
    
    func updateData(_ data: [String: Any],
              at collection: String,
              with id: String
    ) async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            database.collection(collection).document(id).updateData(data) { error in
                if error != nil {
                    continuation.resume(throwing: FireBaseError.save)
                }
                continuation.resume()
            }
        }
    }
    
    func deleteDocument(with id: String,
                at collection: String
    ) async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            database.collection(collection).document(id).delete { error in
                if error != nil {
                    continuation.resume(throwing: FireBaseError.delete)
                }
                continuation.resume()
            }
        }
    }
    
    func fetch(at collection: String) async throws -> [QueryDocumentSnapshot] {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[QueryDocumentSnapshot], Error>) in
            database.collection(collection).getDocuments { querySnapshot, error in
                if error != nil {
                    continuation.resume(throwing: FireBaseError.fetch)
                }
                
                if let documents = querySnapshot?.documents {
                    continuation.resume(returning: documents)
                }
            }
        }
    }
}

enum FireBaseError: LocalizedError {
    case fetch
    case save
    case delete
}
