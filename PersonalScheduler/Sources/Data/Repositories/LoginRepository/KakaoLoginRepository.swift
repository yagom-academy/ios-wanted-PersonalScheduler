//
//  KakaoLoginRepository.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import FirebaseAuth
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

final class KakaoLoginRepository: LoginRepository {
    let service: LoginService
    
    init(service: LoginService = FirebaseAuthService()) {
        self.service = service
    }
    
    func login(completion: @escaping (Result<Void, LoginError>) -> Void) {
        if AuthApi.hasToken() == true {
            UserApi.shared.accessTokenInfo { _, error in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() {
                        self.authorizationKakao(completion: completion)
                    } else {
                        completion(.failure(.unknown))
                    }
                } else {
                    guard let idToken = TokenManager.manager.getToken()?.idToken else {
                        completion(.failure(.invalidToken))
                        return
                    }
                    
                    self.loginFirebase(token: idToken, completion: completion)
                }
            }
        }
        
        if AuthApi.hasToken() == false {
            authorizationKakao(completion: completion)
        }
    }
}

private extension KakaoLoginRepository {
    func authorizationKakao(completion: @escaping (Result<Void, LoginError>) -> Void) {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { token, error in
                guard error == nil,
                      let idToken = token?.idToken else {
                    return
                }
                
                self.loginFirebase(token: idToken, completion: completion)
            }
        }
        
        if UserApi.isKakaoTalkLoginAvailable() == false {
            UserApi.shared.loginWithKakaoAccount { token, error in
                guard error == nil,
                      let idToken = token?.idToken else {
                    return
                }
                
                self.loginFirebase(token: idToken, completion: completion)
            }
        }
    }
    
    func loginFirebase(token: String, completion: @escaping (Result<Void, LoginError>) -> Void) {
        let credential = OAuthProvider.credential(
            withProviderID: "oidc.kakao",
            idToken: token,
            rawNonce: nil
        )
        service.login(with: credential, completion: completion)
    }
}
