//
//  SignInRepository.swift
//  PersonalScheduler
//
//  Created by TORI on 2023/01/13.
//

import Foundation

final class SignInRepository: SignInRepositoryProtocol {
    
    private let appleAuthService = AppleAuthorityService()
    
    func appleIDAuthorization() {
        appleAuthService.didCompleteWithAuthorization = { auth in
            
        }
        appleAuthService.didCompleteWithError = { error in
            
        }
        appleAuthService.performAuthorizationRequest()
    }
}
