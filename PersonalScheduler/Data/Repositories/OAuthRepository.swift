//
//  OAuthRepository.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/10.
//

import Foundation
import FirebaseAuth

final class OAuthRepository: OAuthRepositoryInterface {
    private let appleOAuthService = AppleOAuthService()
    private let kakaoOAuthService = KakaoOAuthService()

    func loginWith(_ type: OAuthType, completion: @escaping (Result<AuthDataResult?, Error>) -> Void) {
        let completion: ((Result<AuthDataResult?, Error>) -> Void) = { result in
            completion(result)
        }

        switch type {
        case .apple:
            appleOAuthService.didFinishedAuth = completion
            appleOAuthService.startSignInWithAppleFlow()
        case .kakao:
            kakaoOAuthService.startSignInWithKakaoFlow(completion: completion)
        case .naver:
            break
        }
    }
}
