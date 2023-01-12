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

                querySnapshot.documents.forEach { document in
                    if document.documentID == firebaseID {
                        continuation.resume(returning: false)
                    }
                }

                continuation.resume(returning: true)
            }
        }
    }
    
}
