//
//  UserManager.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/10.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore

class UserManager {
    static let shared = UserManager()

    private let db = Firestore.firestore()
    
    func createUser(email: String, name: String,_ completion: @escaping (Error?) -> Void) {
        let user = User(name: name, email: email)
        do {
            try db.collection(Collection.user.rawValue).document(Auth.auth().currentUser!.uid).setData(from: user, completion: { error in
                if let error {
                    completion(error)
                } else {
                    completion( nil)
                }
            })
        } catch {
            completion(error)
        }
    }
    
    func getCurrentUserUid(_ completion: @escaping (String, Error?) -> Void) {
        if let user = Auth.auth().currentUser {
            completion(user.uid, nil)
        } else {
            completion("", AuthError.notFoundCurrentUser)
        }
    }
}
