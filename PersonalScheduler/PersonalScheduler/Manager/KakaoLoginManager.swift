//
//  KakaoLoginManager.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/09.
//

import KakaoSDKUser
import FirebaseAuth

final class KakaoLoginManager {
    
    private let firebaseLoginManager = FirebaseLoginManager()
    
    @MainActor
    func handleLogin() async -> Bool {
        
        await withCheckedContinuation { continuation in
            if (UserApi.isKakaoTalkLoginAvailable()) {
                UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                    if let error = error {
                        print(error)
                        continuation.resume(returning: false)
                    }
                    else {
                        print("loginWithKakaoTalk() success.")
                        //do something
                        _ = oauthToken
                        continuation.resume(returning: true)
                    }
                }
            } else {
                UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    if let error = error {
                        print(error)
                        continuation.resume(returning: false)
                    }
                    else {
                        print("loginWithKakaoAccount() success.")
                        //do something
                        _ = oauthToken
                        
                        UserApi.shared.me { [weak self] kuser, error in
                            if let error = error {
                                print("Error: \(error.localizedDescription)")
                                
                            } else {
                                self?.firebaseLoginManager.handleLogin(
                                    email: (kuser?.kakaoAccount?.email)!,
                                    password: String(describing: kuser?.id)
                                )
                            }
                        }
                        continuation.resume(returning: true)
                    }
                }
            }
        }
    }
    
    @MainActor
    func handleLogout() async -> Bool {
        
        await withCheckedContinuation { [weak self] continuation in
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("logout() success.")
                    self?.firebaseLoginManager.handleLogout()
                    continuation.resume(returning: true)
                }
            }
        }
    }
}
