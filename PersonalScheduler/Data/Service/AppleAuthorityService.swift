//
//  AppleAuthorityService.swift
//  PersonalScheduler
//
//  Created by TORI on 2023/01/12.
//

import Foundation
import AuthenticationServices
import FirebaseAuth
import CryptoKit

final class AppleAuthorityService: NSObject {
    
    var didCompleteWithAuthorization: ((ASAuthorization) -> Void)?
    var didCompleteWithError: ((Error) -> Void)?
    
    var currentNonce: String?
    
    func performAuthorizationRequest() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.email, .fullName]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
          return String(format: "%02x", $0)
        }.joined()

        return hashString
      }

      private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length

        while remainingLength > 0 {
          let randoms: [UInt8] = (0 ..< 16).map { _ in
            var random: UInt8 = 0
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if errorCode != errSecSuccess {
              fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
            }
            return random
          }

          randoms.forEach { random in
            if remainingLength == 0 {
              return
            }

            if random < charset.count {
              result.append(charset[Int(random)])
              remainingLength -= 1
            }
          }
        }

        return result
      }
}

// MARK: - ASAuthorizationControllerDelegate

extension AppleAuthorityService: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        
        guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
              }
        guard let appleIDToken = appleIDCredential.identityToken else {
            print("Unable to fetch identity token")
            return
        }
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
            return
        }
        
        let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
        
        Auth.auth().signIn(with: credential) { result, error in
            
        }
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
