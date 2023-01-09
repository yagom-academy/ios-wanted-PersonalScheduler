//
//  KakaoLoginManager.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/09.
//

import KakaoSDKUser

final class KakaoLoginManager {
    
    @MainActor
    func handleKakaoLogin() async -> Bool {
        
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
                        continuation.resume(returning: true)
                    }
                    else {
                        print("loginWithKakaoAccount() success.")
                        //do something
                        _ = oauthToken
                        continuation.resume(returning: true)
                    }
                }
            }
        }
    }
    
    @MainActor
    func handleKakaoLogout() async -> Bool {
        
        await withCheckedContinuation { continuation in
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("logout() success.")
                    continuation.resume(returning: true)
                }
            }
        }
    }
}
