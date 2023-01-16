//
//  KakaoLoginManager.swift
//  PersonalScheduler
//
//  Created by 이예은 on 2023/01/13.
//

import Foundation
import FirebaseAuth
import KakaoSDKUser
import KakaoSDKAuth

class KakaoLoginManager {
    func kakaoLoginInWeb(completion: @escaping (OAuthToken?) -> Void) {
        UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
            if let error = error {
                print("카카오 로그인 실패!!📘")
                completion(nil)
            } else {
                print("성공!!📕")
                completion(oauthToken)
            }
        }
    }
    
    func getUserInfo(completion: @escaping (AuthDataResult?) -> Void) {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            
            Auth.auth().signIn(withEmail: (user?.kakaoAccount?.email)!,
                               password: "\(String(describing: user?.id))") { result, error in
                if error != nil {
                    Auth.auth().createUser(withEmail: (user?.kakaoAccount?.email)!,
                                           password: "\(String(describing: user?.id))") { result, error in
                        if error != nil {
                            completion(result)
                            return
                        }
                    }
                    return
                }
                
                print("로그인 성공 📘")
                completion(result)
            }
            
            
        }
    }
}
