//
//  AppleAuthorityService.swift
//  PersonalScheduler
//
//  Created by TORI on 2023/01/12.
//

import Foundation
import AuthenticationServices

final class AppleAuthorityService: NSObject {
    
    var didCompleteWithAuthorization: ((ASAuthorization) -> Void)?
    var didCompleteWithError: ((Error) -> Void)?
    
    func performAuthorizationRequest() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.email, .fullName]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

// MARK: - ASAuthorizationControllerDelegate

extension AppleAuthorityService: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        didCompleteWithAuthorization?(authorization)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        didCompleteWithError?(error)
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding

extension AppleAuthorityService: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return UIWindow() }
        return appDelegate.window!
    }
}
