//
//  AuthUseCase.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/12.
//

import Foundation
import AuthenticationServices

enum AuthType {
    case kakao, apple
}

final class AuthUseCase {
    
    let kakaoAuthRepository: KakaoAuthRepository
    let appleAuthRespository: AppleAuthRespository
    let keychainRepository: KeyChainRepository
    
    init() {
        self.kakaoAuthRepository = DefaultKakaoAuthRepository()
        self.appleAuthRespository = DefaultAppleAuthRespository()
        self.keychainRepository = DefaultKeyChainRepository()
    }
    
    func login(authType: AuthType) async throws {
        switch authType {
        case .kakao:
            let accessToken = try await kakaoAuthRepository.isKakaoTalkLoginAvailable()
            let userId = try await kakaoAuthRepository.userId()
            try await keychainRepository.setUserId(String(describing: userId))
            try await keychainRepository.setAccessToken(accessToken)
        case .apple:
            let userId = try await appleAuthRespository.loginWithApple()
            try await keychainRepository.setUserId(userId)
        }
    }
    
    func getAppleAuthorizationController() -> ASAuthorizationController {
        return appleAuthRespository.authorizationController
    }
    
    func checKakaoAutoSign() async throws -> Bool {
        return try await kakaoAuthRepository.autoLogInCheck()
    }
    
    func checAppleAutoSign() async throws -> Bool {
        let userId = try await keychainRepository.getUserId()
        return try await appleAuthRespository.checkAutoSign(userId: userId)
    }
}

