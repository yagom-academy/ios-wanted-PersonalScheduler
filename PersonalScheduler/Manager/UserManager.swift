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
    private let collectionName = "User"
    private let db = Firestore.firestore()
    
    func createUser(email: String, name: String) {
        let user = User(name: name, email: email, schedulList: [])
        do {
            try db.collection(collectionName).document(Auth.auth().currentUser!.uid).setData(from: user, completion: { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Firebase 저장 성공")
                }
            })
        } catch {
            print(error.localizedDescription)
        }
    }
}
