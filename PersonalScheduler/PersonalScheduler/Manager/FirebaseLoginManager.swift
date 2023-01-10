//
//  FirebaseLoginManager.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/09.
//

import FirebaseAuth

final class FirebaseLoginManager {
    
    func handleLogin(email: String, password: String, completion: @escaping (String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            completion(Auth.auth().currentUser?.uid ?? "")
        }
    }
    
    func handleSignUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                Auth.auth().signIn(withEmail: email, password: password, completion: nil)
            }
        }
    }
    
    func handleLogout() {
        try? Auth.auth().signOut()
    }
}
