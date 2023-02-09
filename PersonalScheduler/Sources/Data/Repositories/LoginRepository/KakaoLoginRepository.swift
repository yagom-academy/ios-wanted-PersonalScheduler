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
    @Published private(set) var loginResult: Bool = false
    private var cancellable = Set<AnyCancellable>()
    let service: LoginService
    
    init(service: LoginService = FirebaseAuthService()) {
        self.service = service
    }
    
    func login() -> AnyPublisher<Bool, Never> {
        if AuthApi.hasToken() == true {
            UserApi.shared.accessTokenInfo { _, error in
                guard error == nil else {
                    self.handleTokenError(error: error)
                    return
                }
                self.authorizationKakao()
            }
        }
        
        if AuthApi.hasToken() == false {
            self.authorizationKakao()
        }
        return AnyPublisher($loginResult)
    }
    
    private func tokenHandle() {
        UserApi.shared.accessTokenInfo { _, error in
            guard error == nil else {
                self.handleTokenError(error: error)
                return
            }
            
            self.authorizationKakao()
        }
    }
    
    private func handleTokenError(error: Error?) {
        guard let error = error as? SdkError else {
            self.loginResult = false
            return
        }
        
        if error.isInvalidTokenError() {
            authorizationKakao()
        }
    }
    
    private func authorizationKakao() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk(completion: handleToken)
        }
        
        if UserApi.isKakaoTalkLoginAvailable() == false {
            UserApi.shared.loginWithKakaoAccount(completion: handleToken)
        }
    }
    
    private func handleToken(token: OAuthToken?, error: Error?) {
        guard error == nil,
              let idToken = token?.idToken else {
            self.loginResult = false
            return
        }
        
        loginFirebase(token: idToken)
    }
    
    func loginFirebase(token: String) {
        let credential = OAuthProvider.credential(
            withProviderID: "oidc.kakao",
            idToken: token,
            rawNonce: nil
        )
        
        service.login(with: credential)
            .sink { self.loginResult = $0 }
            .store(in: &cancellable)
        
    }
}
