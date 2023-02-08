//
//  LoginService.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/08.
//

import Foundation
import FirebaseAuth

final class LoginService {
    func requestLogin(with token: String, completion: @escaping ((Result<String, Error>) -> Void)) {
        let credential = FacebookAuthProvider.credential(withAccessToken: token)
        
        Auth.auth().signIn(with: credential) { result, error in
            if let error {
                completion((.failure(error)))
                return
            }
            guard let uid = result?.user.uid else { return }
            completion(.success(uid))
        }
    }
    
    func requestLogout(completion: @escaping ((Result<Void, Error>) -> Void)) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch {
            completion((.failure(error)))
        }
    }
}
