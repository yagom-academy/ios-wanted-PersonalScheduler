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

final class KakaoAuthRepository {
    
    /// 카카오톡 어플이 설치되어있는지 확인하는 로직
    func isKakaoTalkLoginAvailable() async throws -> String {
        
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.main.async {
                if UserApi.isKakaoTalkLoginAvailable() {
                    self.loginWithKakaoTalk { result in
                        continuation.resume(with: result)
                    }
                } else {
                    self.loginWithKakaoAccount { result in
                        continuation.resume(with: result)
                    }
                }
            }
        }
    }

}

// MARK: - Logout
extension KakaoAuthRepository {

    func logoutWithKakao(completion: @escaping (Result<Void, Error>) -> Void) {
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
            }
        }
    }

}

// MARK: - Token
extension KakaoAuthRepository {
    
    func autoLogInCheck() async throws -> Bool {
        return try await withCheckedThrowingContinuation { continuation in
            self.hasToken { result in
                continuation.resume(with: result)
            }
        }
    }

    func hasToken(completion: @escaping (Result<Bool, Error>) -> Void) {
        if (AuthApi.hasToken()) {
            UserApi.shared.accessTokenInfo { (_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        completion(.success(false))
                    }
                    else {
                        completion(.failure(error))
                    }
                }
                else {
                    completion(.success(true))
                }
            }
        }
        else {
            completion(.success(false))
        }
    }

}


// MARK: - Login
private extension KakaoAuthRepository {

    /// 카카오톡 어플을 통해 로그인합니다.
    func loginWithKakaoTalk(completion: @escaping (Result<String, Error>) -> Void) {
        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
            guard let authToken = oauthToken else { return }
            
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(authToken.accessToken))
            }
        }
    }

    /// 카카오톡 어플이 없는 경우, 카카오톡 계정을 통해 로그인합니다.
    func loginWithKakaoAccount(completion: @escaping (Result<String, Error>) -> Void) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            guard let authToken = oauthToken else { return }
            
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(authToken.accessToken))
            }
        }
    }
}
