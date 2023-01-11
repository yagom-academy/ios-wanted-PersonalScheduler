//
//  KakaoOAuthService.swift
//  PersonalScheduler
//
//  Created by minsson on 2023/01/12.
//

import Foundation
import KakaoSDKUser

final class KakaoOAuthService {
    
    func executeLoginWithKakaoTalk() {
        // 카카오톡 실행 가능 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("loginWithKakaoTalk() success.")
                    
                    //do something
                    _ = oauthToken
                }
            }
        }
    }
    
    func executeLoginWithKakaoAccount() {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                //do something
                _ = oauthToken
            }
        }
    }
    
}
