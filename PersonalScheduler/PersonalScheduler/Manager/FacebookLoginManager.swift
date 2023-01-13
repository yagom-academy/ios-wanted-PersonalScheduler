//
//  FacebookLoginManager.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/12.
//

import Foundation
import FacebookLogin

final class FacebookLoginManager {
    
    private let loginManager = LoginManager()
    
    func loginFacebook(completion: @escaping (Result<String, Error>) -> Void) {
        loginManager.logIn(permissions: ["email"],
                           from: nil) { loginManagerLoginResult, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            let token = loginManagerLoginResult?.token?.tokenString
            completion(.success(token ?? ""))
        }
    }
    
    func logoutFacebook() {
        loginManager.logOut()
    }
    
}
