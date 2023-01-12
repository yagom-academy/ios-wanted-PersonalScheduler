//
//  FirebaseLoginManager.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/09.
//

import FirebaseAuth

final class FirebaseLoginManager {
    
    private let facebookLoginManager = FacebookLoginManager()
    
    enum FirebaseLoginError: Error {
        case badPassword
    }
    
    func handleLogin(email: String, password: String, completion: @escaping (Result<KakaoInfo, FirebaseLoginError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(.badPassword))
            } else {
                completion(.success(KakaoInfo(uid: Auth.auth().currentUser?.uid ?? "", email: email, password: password)))
                print(password)
            }
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
    
    func loginWithFacebook(completion: @escaping (Result<User, Error>) -> Void) {
        facebookLoginManager.loginFacebook { result in
            switch result {
            case .success(let accessToken):
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
                
                Auth.auth().signIn(with: credential) { authDataResult, error in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                        completion(.failure(error))
                        return
                    } else {
                        let email = authDataResult?.user.email ?? "No email"
                        print("New email: \(email)")
                        completion(.success(authDataResult!.user))
                    }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
}
