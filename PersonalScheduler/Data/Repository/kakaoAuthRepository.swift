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
    
    /// 카카오톡 유저 id를 반환합니다.
    func userId(completion: @escaping (Int64) -> Void) {
        UserApi.shared.me {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                
                //do something
                _ = user
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
    
    func hasToken() {
        
    }

    func accessTokenInfo(completion: @escaping (Result<Void, Error>) -> Void) {
        UserApi.shared.accessTokenInfo { (_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        //로그인 필요
                    }
                    else {
                        //기타 에러
                    }
                }
                else {
                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                }
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
