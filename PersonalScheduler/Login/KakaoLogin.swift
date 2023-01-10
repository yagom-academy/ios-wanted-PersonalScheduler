//
//  AppleLogin.swift
//  PersonalScheduler
//
//  Created by 우롱차 on 2023/01/10.
//

import Foundation
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

final class KakaoLogin: Login {
    func getId() -> Observable<Result<String, Error>?> {
        var scope: [String] = []
        scope.append("account_email")
        let result: Observable<Result<String, Error>?> = .init(nil)
        
        guard UserApi.isKakaoTalkLoginAvailable() == true else {
            result.value = .failure(LoginError.kakaoInstallNeed)
            return result
        }
        
        UserApi.shared.loginWithKakaoTalk { token, error in
            if error != nil {
                result.value = .failure(LoginError.kakaoLodedError)
            } else {
                UserApi.shared.me { user, error in
                    guard let id = user?.id else {
                        result.value = .failure(LoginError.kakaoLodedError)
                        return
                    }
                    result.value = .success(String(id))
                }
            }
        }
         
        return result
    }
}
