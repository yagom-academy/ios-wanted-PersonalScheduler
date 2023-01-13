//
//  SignInRepository.swift
//  PersonalScheduler
//
//  Created by TORI on 2023/01/13.
//

import Foundation
import FirebaseAuth

final class SignInRepository: SignInRepositoryProtocol {
    
    private let appleAuthService = AppleAuthorityService()
    
    func appleIDAuthorization(completion: @escaping (Result<AuthDataResult?, Error>) -> Void) {
        appleAuthService.didCompleteWithAuthorization = {
            completion(.success($0))
        }
        appleAuthService.didCompleteWithError = {
            completion(.failure($0))
        }
        appleAuthService.performAuthorizationRequest()
    }
}
