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
    enum Constants {
        static let oAuthProviderID: String = "oidc.kakao"
    }
    
    let service: LoginService
    
    init(service: LoginService = FirebaseAuthService()) {
        self.service = service
    }
    
    func login(completion: @escaping (Result<Void, LoginError>) -> Void) {
        if AuthApi.hasToken() == true {
            handleTokenInfoError(completion: completion)
        }
        
        if AuthApi.hasToken() == false {
            authorizationKakao(completion: completion)
        }
    }
}

private extension KakaoLoginRepository {
    func handleTokenInfoError(completion: @escaping (Result<Void, LoginError>) -> Void) {
        UserApi.shared.accessTokenInfo { [weak self] _, error in
            if let error = error as? SdkError, error.isInvalidTokenError() {
                self?.authorizationKakao(completion: completion)
            }
            
            if error == nil {
                self?.existToken(completion: completion)
            }
        }
    }
    
    func existToken(completion: @escaping (Result<Void, LoginError>) -> Void) {
        guard let token = TokenManager.manager.getToken()?.idToken else {
            completion(.failure(.invalidToken))
            return
        }
        
        loginFirebase(token: token, completion: completion)
    }
    
    
    func authorizationKakao(completion: @escaping (Result<Void, LoginError>) -> Void) {
        if UserApi.isKakaoTalkLoginAvailable() == true {
            guard let token = try? UserApi.shared.authorizeKakaoTalk() else {
                completion(.failure(.loginServiceError))
                return
            }
            
            loginFirebase(token: token, completion: completion)
        }
        
        if UserApi.isKakaoTalkLoginAvailable() == false {
            guard let token = try? UserApi.shared.authorizeKakaoAccount() else {
                completion(.failure(.loginServiceError))
                return
            }
            
            loginFirebase(token: token, completion: completion)
        }
    }
    
    func loginFirebase(token: String, completion: @escaping (Result<Void, LoginError>) -> Void) {
        let credential = OAuthProvider.credential(
            withProviderID: Constants.oAuthProviderID,
            idToken: token,
            rawNonce: nil
        )
        service.login(with: credential, completion: completion)
    }
}

private extension UserApi {
    func authorizeKakaoTalk() throws -> String {
        var idToken: String? = nil
        AuthController.shared.authorizeWithTalk { [weak self] token, error in
            idToken = self?.handleAuthControllerResult(token: token, error: error)
        }
        
        guard let idToken = idToken else {
            throw LoginError.failDecodeToken
        }
        
        return idToken
    }
    
    func authorizeKakaoAccount() throws -> String {
        var idToken: String? = nil
        AuthController.shared.authorizeWithAuthenticationSession { [weak self] token, error in
            idToken = self?.handleAuthControllerResult(token: token, error: error)
        }
        
        guard let idToken = idToken else {
            throw LoginError.failDecodeToken
        }
        
        return idToken
    }
    
    func handleAuthControllerResult(
        token: OAuthToken?,
        error: Error?
    ) -> String? {
        guard error == nil,
              let idToken = token?.idToken else {
            return nil
        }
        
        return idToken
    }
}
