//
//  FirestoreRepository.swift
//  PersonalScheduler
//
//  Created by junho lee on 2023/02/09.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class FirestoreRepository<T: FirestoreEntityType> {
    private lazy var firestore = Firestore.firestore()
    private let collection: String

    init(collection: String) {
        self.collection = collection
    }


    func fetchAll(completion: @escaping ([T]) -> Void) {
        firestore.collection(collection).getDocuments { querySnapshot, error in
            if let error {
                print(error.localizedDescription)
                completion([])
                return
            }
            guard let documents = querySnapshot?.documents else {
                completion([])
                return
            }
            var modelData = [T]()
            documents.forEach { document in
                if let data = try? document.data(as: T.self) {
                    modelData.append(data)
                }
            }
            completion(modelData)
        }
    }

    func add(_ data: T) {
        do {
            let reference = firestore.collection(collection).document(data.document)
            try reference.setData(from: data)
        } catch {
            print(error.localizedDescription)
        }
    }

    func update(_ data: T) {
        let reference = firestore.collection(collection).document(data.document)
        reference.updateData(data.firestoreData) { error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }

    func delete(_ data: T) {
        firestore.collection(collection).document(data.document).delete { error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }
}
