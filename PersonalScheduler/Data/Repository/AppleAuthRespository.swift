//
//  AppleAuthRespository.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/12.
//

import Foundation
import AuthenticationServices

final class AppleAuthRespository: NSObject {
    
    private var authcontinuation: CheckedContinuation<String, Error>?
    
    lazy var authorizationController: ASAuthorizationController = {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        return authorizationController
    }()
    
    func loginWithApple() async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            authcontinuation = continuation
            authorizationController.performRequests()
        }
    }
}

extension AppleAuthRespository: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            authcontinuation?.resume(returning: appleIDCredential.user)
        } else {
            authcontinuation?.resume(throwing: NetworkError.apple)
        }
        
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        authcontinuation?.resume(throwing: error)
    }
}

enum NetworkError: LocalizedError {
    case apple
}
