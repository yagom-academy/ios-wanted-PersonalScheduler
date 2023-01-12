//
//  KakaoOAuthService.swift
//  PersonalScheduler
//
//  Created by minsson on 2023/01/12.
//

import Foundation
import KakaoSDKUser

final class KakaoOAuthService {
    
    func executeLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            executeLoginWithKakaoTalk()
        } else {
            executeLoginWithKakaoAccount()
        }
    }
    
    func executeLogout() {
        UserApi.shared.logout { error in
            guard error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
            
            print("logout() success.")
        }
    }
    
    private func executeLoginWithKakaoAccount() async -> Int64 {
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                guard error == nil else {
                    print(error?.localizedDescription as Any)
                    return
                }
                
                UserApi.shared.me { user, error in
                    guard error == nil else {
                        print(error?.localizedDescription as Any)
                        return
                    }
                    
                    guard let userID = user?.id else {
                        return
                    }
                    continuation.resume(returning: userID)
                }
            }
        }
    }
    
    private func executeLoginWithKakaoTalk() async -> Int64 {
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                guard error == nil else {
                    print(error?.localizedDescription as Any)
                    return
                }
                
                UserApi.shared.me { user, error in
                    guard error == nil else {
                        print(error?.localizedDescription as Any)
                        return
                    }
                    
                    guard let userIDNumber = user?.id else {
                        return
                    }
                    
                    continuation.resume(returning: userIDNumber)
                }
                
            }
        }
    }
    
}
