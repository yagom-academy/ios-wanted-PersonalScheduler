//
//  FirebaseLoginManager.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/12.
//

import Foundation
import FirebaseAuth
import KakaoSDKUser

class FirebaseLoginManager {
    static let shared = FirebaseLoginManager()
    
    func loginFirebaseForKakao(_ completion: @escaping (Error?) -> Void) {
        UserApi.shared.me() { user, error in
            if let error {
                completion(error)
            } else {
                Auth.auth().createUser(withEmail: (user?.kakaoAccount?.email)!,
                                       password: "\(String(describing: user?.id))") { result, error in
                    if let error {
                        Auth.auth().signIn(withEmail: (user?.kakaoAccount?.email)!,
                                           password: "\(String(describing: user?.id))")
                        completion(error)
                    } else {
                        UserManager.shared.createUser(email: (user?.kakaoAccount?.email)!, name: (user?.kakaoAccount?.profile?.nickname)!) { error in
                            if let error {
                                completion(error)
                            } else {
                                completion(nil)
                            }
                        }
                    }
                }
            }
        }
    }
}
