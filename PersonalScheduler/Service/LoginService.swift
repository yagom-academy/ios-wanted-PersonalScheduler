//
//  LoginService.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/08.
//

import Foundation
import FirebaseAuth

final class LoginService {
    enum LoginProvider {
        case facebook
        case kakao
    }
    
    func requestLogin(
        to provider: LoginProvider,
        with token: String,
        completion: @escaping ((Result<String, Error>) -> Void)
    ) {
        let credential: AuthCredential
        
        switch provider {
        case .facebook:
            credential = FacebookAuthProvider.credential(withAccessToken: token)
        case .kakao:
            credential = OAuthProvider.credential(withProviderID: "oidc.kakao", idToken: token, rawNonce: nil)
        }
        
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
