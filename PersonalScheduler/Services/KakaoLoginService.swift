//
//  KakaoLoginService.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/11.
//

import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

final class KakaoLoginService {
    
    func login(_ completion: @escaping (OAuthToken?) -> Void ) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    print(error)
                    completion(nil)
                } else {
                    print("loginWithKakaoTalk() success.")
                    completion(oauthToken)
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print(error)
                    completion(nil)
                } else {
                    print("loginWithKakaoAccount() success.")
                    completion(oauthToken)
                }
            }
        }
    }
    
    func logout() {
        UserApi.shared.logout { (error) in
            if let error = error {
                print(error)
            } else {
                print("logout() success")
            }
        }
    }
    
    func searchUserAccessToken(_ completion: @escaping (AccessTokenInfo?) -> Void) {
        UserApi.shared.accessTokenInfo { (accessTokenInfo, error) in
            if let error = error {
                print(error)
                completion(nil)
            } else {
                print("accessTokenInfo() success.")
                completion(accessTokenInfo)
            }
        }
    }
    
    func searchUserInfo(_ completion: @escaping (User?) -> Void) {
        UserApi.shared.me { (user, error) in
            if let error = error {
                print(error)
                completion(nil)
            } else {
                print("me() success.")
                completion(user)
            }
        }
    }
}
