//
//  AppleOAuthService.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/10.
//

import Foundation
import AuthenticationServices
import CryptoKit
import FirebaseAuth

final class AppleOAuthService: NSObject {

    private var currentNonce: String?
    var didFinishedAuth: ((Result<AuthDataResult?, Error>) -> Void)?

    func startSignInWithAppleFlow() {
      let nonce = randomNonceString()
      currentNonce = nonce
      let appleIDProvider = ASAuthorizationAppleIDProvider()
      let request = appleIDProvider.createRequest()
      request.requestedScopes = [.fullName, .email]
      request.nonce = sha256(nonce)

      let authorizationController = ASAuthorizationController(authorizationRequests: [request])
      authorizationController.delegate = self
      authorizationController.presentationContextProvider = self
      authorizationController.performRequests()
    }
}

// MARK: - ASAuthorizationControllerDelegate

extension AppleOAuthService: ASAuthorizationControllerDelegate {

  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
      guard let nonce = currentNonce else {
          didFinishedAuth?(.failure(OAuthError.noLoginRequestSended))
          return
      }
      guard let appleIDToken = appleIDCredential.identityToken else {
          didFinishedAuth?(.failure(OAuthError.identityTokenFetchFailed))
        return
      }
      guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
          didFinishedAuth?(.failure(OAuthError.dataSerializeFailed))
        return
      }
      // Initialize a Firebase credential.
      let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                idToken: idTokenString,
                                                rawNonce: nonce)
      // Sign in with Firebase.
      Auth.auth().signIn(with: credential) { [weak self] (authResult, error) in
        if let error = error {
            self?.didFinishedAuth?(.failure(error))
          return
        }
          self?.didFinishedAuth?(.success(authResult))
      }
    }
  }

  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
      didFinishedAuth?(.failure(error))
  }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding

extension AppleOAuthService: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows.filter { $0.isKeyWindow }.first ?? UIWindow()
    }
}

// MARK: - Random Nonce Generate & SHA256

extension AppleOAuthService {
    /// Firebase 공식문서에서 안내하고 있는 randomNonceString 생성방법입니다.
    /// Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError(
              "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
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

    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }
}
