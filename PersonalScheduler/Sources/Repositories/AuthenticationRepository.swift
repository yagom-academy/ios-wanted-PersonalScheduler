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
import FacebookLogin

protocol AuthenticationRepository {
    func kakaoAuthorize() -> AnyPublisher<Authentication?, Error>
    func appleAuthorizationController() -> ASAuthorizationController
    func appleAuthorize() -> AnyPublisher<Authentication?, Error>
    func facebookAuthorize() -> AnyPublisher<Authentication?, Error>
    func readToken(option tokenOption: TokenOption) -> AnyPublisher<Authentication, Never>
    func writeToken(authentication: Authentication)
    func removeToken(option tokenOption: TokenOption)
}

final class DefaultAuthenticationRepository: NSObject, AuthenticationRepository {
    
    private let apiProvider: APIProvider
    private let keychainStorage: KeyChainStorageService
    
    init(
        apiProvider: APIProvider = DefaultAPIProvider(),
        keychainStorage: KeyChainStorageService = KeyChainStorage.shard
    ) {
        self.apiProvider = apiProvider
        self.keychainStorage = keychainStorage
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
    
    func appleAuthorizationController() -> ASAuthorizationController {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        return controller
    }
    
    func appleAuthorize() -> AnyPublisher<Authentication?, Error> {
        return authentication.eraseToAnyPublisher()
    }
    
    func facebookAuthorize() -> AnyPublisher<Authentication?, Error> {
        let loginManager = LoginManager()
        loginManager.logIn(permissions:[.publicProfile, .email,], viewController: nil) { [weak self] (result) in
            switch result {
            case .cancelled:
                print("User cancelled login")
                self?.authentication.send(completion: .finished)
                
            case .failed(let error):
                self?.authentication.send(completion: .failure(error))
                
            case .success(_, _, let accessToken):
                let tokenString = accessToken?.tokenString
                let userID = accessToken?.userID
                GraphRequest(
                    graphPath: "me",
                    parameters: ["fields": "id, name, picture.type(large), email"]
                ).start { [weak self] (connection, result, error) -> Void in
                    if let error {
                        self?.authentication.send(completion: .failure(error))
                    } else {
                        let userInfo = result as? [String: Any]
                        let profileURL = userInfo?["picture"].flatMap { ($0 as? [String: [String: Any]])?["data"]?["url"] as? String }
                        let authentication = Authentication(
                            accessToken: tokenString,
                            refreshToken: nil,
                            identityToken: nil,
                            authorizeCode: nil,
                            snsUserName: userInfo?["name"] as? String,
                            snsUserEmail: userInfo?["email"] as? String,
                            snsUserId: userID,
                            snsProfileUrl: profileURL
                        )
                        self?.authentication.send(authentication)
                        self?.authentication.send(completion: .finished)
                    }
                }
            }
        }
        return authentication.eraseToAnyPublisher()
    }
    
    func readToken(option tokenOption: TokenOption) -> AnyPublisher<Authentication, Never> {
        var accessToken: String?
        var refreshToken: String?
        if tokenOption.contains(.access) {
            accessToken = keychainStorage.read(.accessToken)
        }
        if tokenOption.contains(.refresh) {
            refreshToken = keychainStorage.read(.refreshToken)
        }
        return Just(Authentication(accessToken: accessToken, refreshToken: refreshToken)).eraseToAnyPublisher()
    }
    
    func writeToken(authentication: Authentication) {
        if let accessToken = authentication.accessToken {
            keychainStorage.write(key: .accessToken, value: accessToken)
        }
        if let refreshToken = authentication.refreshToken {
            keychainStorage.write(key: .refreshToken, value: refreshToken)
        }
    }
    
    func removeToken(option tokenOption: TokenOption) {
        if tokenOption.contains(.access) {
            keychainStorage.delete(key: .accessToken)
        }
        if tokenOption.contains(.refresh) {
            keychainStorage.delete(key: .refreshToken)
        }
    }
    
}

extension DefaultAuthenticationRepository: ASAuthorizationControllerDelegate {
    
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
