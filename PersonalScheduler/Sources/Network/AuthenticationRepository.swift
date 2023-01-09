//
//  AuthenticationRepository.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/09.
//

import Foundation
import Combine
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices

final class AuthenticationRepository: NSObject {
    
    private let apiProvider: APIProvider
    
    init(apiProvider: APIProvider) {
        self.apiProvider = apiProvider
    }
    
    private let authentication = CurrentValueSubject<Authentication?, Error>(nil)
    
    func kakaoAuthorize() -> AnyPublisher<Authentication?, Error> {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { [weak self] oauthToken, error in
                if let error {
                    debugPrint(error)
                    self?.authentication.send(completion: .failure(error))
                } else {
                    UserApi.shared.me { user, error in
                        if let error {
                            debugPrint(error)
                            self?.authentication.send(completion: .failure(error))
                        } else {
                            self?.authentication.send(
                                Authentication(
                                    accessToken: oauthToken?.accessToken,
                                    refreshToken: oauthToken?.refreshToken,
                                    identityToken: nil,
                                    authorizeCode: nil,
                                    snsUserName: user?.kakaoAccount?.profile?.nickname,
                                    snsUserEmail: user?.kakaoAccount?.email,
                                    snsUserId: user?.id?.description,
                                    snsProfileUrl: user?.kakaoAccount?.profile?.profileImageUrl?.absoluteString
                                )
                            )
                            self?.authentication.send(completion: .finished)
                        }
                    }
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] oauthToken, error in
                if let error {
                    debugPrint(error)
                    self?.authentication.send(completion: .failure(error))
                } else {
                    UserApi.shared.me { user, error in
                        if let error {
                            debugPrint(error)
                            self?.authentication.send(completion: .failure(error))
                        } else {
                            self?.authentication.send(
                                Authentication(
                                    accessToken: oauthToken?.accessToken,
                                    refreshToken: oauthToken?.refreshToken,
                                    identityToken: nil,
                                    authorizeCode: nil,
                                    snsUserName: user?.kakaoAccount?.profile?.nickname,
                                    snsUserEmail: user?.kakaoAccount?.email,
                                    snsUserId: user?.id?.description,
                                    snsProfileUrl: user?.kakaoAccount?.profile?.profileImageUrl?.absoluteString
                                )
                            )
                            self?.authentication.send(completion: .finished)
                        }
                    }
                }
            }
        }
        return authentication.eraseToAnyPublisher()
    }
    
    func appleAuthorize() -> ASAuthorizationController {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        return controller
    }
    
}

extension AuthenticationRepository: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credential as ASAuthorizationAppleIDCredential:
            guard let identityTokenData = credential.identityToken,
                  let authorizationCodeData = credential.authorizationCode,
                  let identityToken = String(data: identityTokenData, encoding: .utf8),
                  let authorizationCode = String(data: authorizationCodeData, encoding: .utf8)
            else {
                return
            }
            let authentication = Authentication(
                accessToken: nil,
                refreshToken: nil,
                identityToken: identityToken,
                authorizeCode: authorizationCode,
                snsUserName: credential.fullName?.givenName ?? "apple user",
                snsUserEmail: credential.email,
                snsUserId: credential.user,
                snsProfileUrl: "https://raw.githubusercontent.com/WeEscape/resources/main/appleProfile.jpeg"
            )
            self.authentication.send(authentication)
            self.authentication.send(completion: .finished)
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        authentication.send(completion: .failure(error))
    }
    
}
