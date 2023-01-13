//
//  SignRepository.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/12.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

final class DefaultKakaoAuthRepository: KakaoAuthRepository {
    
    /// 카카오톡 어플이 설치되어있는지 확인하는 로직
    func isKakaoTalkLoginAvailable() async throws -> String {
        
        if UserApi.isKakaoTalkLoginAvailable() {
            return try await self.loginWithKakaoTalk()
        } else {
            return try await self.loginWithKakaoAccount()
        }
    }

}

// MARK: - Token
extension DefaultKakaoAuthRepository {
    
    func autoLogInCheck() async throws -> Bool {
        return try await withCheckedThrowingContinuation { continuation in
            if (AuthApi.hasToken()) {
                UserApi.shared.accessTokenInfo { (_, error) in
                    if let error = error {
                        if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                            continuation.resume(throwing: error)
                        }
                        else {
                            continuation.resume(throwing: error)
                        }
                    }
                    else {
                        continuation.resume(returning: true)
                    }
                }
            }
            else {
                continuation.resume(returning: false)
            }
        }
        
    }

}


// MARK: - Login
private extension DefaultKakaoAuthRepository {

    /// 카카오톡 어플을 통해 로그인합니다.
    func loginWithKakaoTalk() async throws -> String {
        
        return try await withCheckedThrowingContinuation { continuation in
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                guard let authToken = oauthToken else { return }
                
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: authToken.accessToken)
                }
            }
        }
    }

    /// 카카오톡 어플이 없는 경우, 카카오톡 계정을 통해 로그인합니다.
    func loginWithKakaoAccount() async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                guard let authToken = oauthToken else { return }
                
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: authToken.accessToken)
                }
            }
        }
    }
}

// MARK: - UserInfo
extension DefaultKakaoAuthRepository {

    /// 카카오톡 유저 id를 반환합니다.
    func userId() async throws -> Int64 {
        return try await withCheckedThrowingContinuation { continuation in
            UserApi.shared.me { user, error in
                if let error = error {
                    continuation.resume(throwing: error)
                }
                else {
                    guard let userId = user?.id else {
                        return
                    }
                    continuation.resume(returning: userId)
                }
            }
        }
        
    }
}

