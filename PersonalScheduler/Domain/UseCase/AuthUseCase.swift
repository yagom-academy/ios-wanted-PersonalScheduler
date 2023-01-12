//
//  AuthUseCase.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/12.
//

import Foundation
import AuthenticationServices

enum AuthType {
    case kakao, apple, facebook
}

final class AuthUseCase {
    
    let kakaoAuthRepository: KakaoAuthRepository = KakaoAuthRepository()
    let appleAuthRespository: AppleAuthRespository = AppleAuthRespository()
    let keychainRepository: KeyChainRepository = KeyChainRepository()
    
    init() { }
    
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
        case .facebook:
            print()
        }
    }
    
    func getAppleAuthorizationController() -> ASAuthorizationController {
        return appleAuthRespository.authorizationController
    }
    
    func autoLoginCheck() async throws -> Bool {
        return try await kakaoAuthRepository.autoLogInCheck()
    }

    func Logout(offset: Int, count: Int) {
//        let fetchRequest = MotionInfo.fetchRequest()
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: MotionInfo.Constant.date, ascending: false)]
//        fetchRequest.fetchOffset = offset
//        fetchRequest.fetchLimit = count
//
//        let motions = coreDataManager.fetch(fetchRequest)
//
//        return motions?.map { MotionInformation(model: $0) }
    }
}

