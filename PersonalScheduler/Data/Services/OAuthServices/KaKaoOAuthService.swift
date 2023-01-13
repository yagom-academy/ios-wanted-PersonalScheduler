//
//  KaKaoOAuthService.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/10.
//

import Foundation
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import FirebaseAuth

final class KakaoOAuthService {

    func startSignInWithKakaoFlow(completion: @escaping (Result<AuthDataResult?, Error>) -> Void) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            UserApi.shared.me { user, error in
                if let error = error {
                    completion(.failure(error))
                }

                if let user = user,
                   let id = user.id {
                    Auth.auth().createUser(withEmail: "\(id)@gmail.com", password: "\(id)") { authResult, error in
                        Auth.auth().signIn(withEmail: "\(id)@gmail.com", password: "\(id)") { authResult, error in
                            if let error = error {
                                print(error)
                                completion(.failure(error))
                                return
                            }
                            completion(.success(authResult))
                        }
                    }
                }
            }
        }
    }
}
