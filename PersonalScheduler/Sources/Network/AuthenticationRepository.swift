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

final class AuthenticationRepository {
    
    private let apiProvider: APIProvider
    
    init(apiProvider: APIProvider) {
        self.apiProvider = apiProvider
    }
    
    func kakaoAuthorize() -> AnyPublisher<Authentication, Error> {
        let authentication = PassthroughSubject<Authentication, Error>()
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error {
                    debugPrint(error)
                    authentication.send(completion: Subscribers.Completion<Error>.failure(error))
                } else {
                    UserApi.shared.me { user, error in
                        if let error {
                            debugPrint(error)
                            authentication.send(completion: Subscribers.Completion<Error>.failure(error))
                        } else {
                            authentication.send(
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
                            authentication.send(completion: Subscribers.Completion<Error>.finished)
                        }
                    }
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error {
                    debugPrint(error)
                    authentication.send(completion: Subscribers.Completion<Error>.failure(error))
                } else {
                    UserApi.shared.me { user, error in
                        if let error {
                            debugPrint(error)
                            authentication.send(completion: Subscribers.Completion<Error>.failure(error))
                        } else {
                            authentication.send(
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
                            authentication.send(completion: Subscribers.Completion<Error>.finished)
                        }
                    }
                }
            }
        }
        return authentication.eraseToAnyPublisher()
    }
    
}
