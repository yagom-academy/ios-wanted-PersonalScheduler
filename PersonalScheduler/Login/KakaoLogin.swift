//
//  AppleLogin.swift
//  PersonalScheduler
//
//  Created by 곽우종 on 2023/01/10.
//

import Foundation
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

final class KakaoLogin: Login {
    func getEmail() -> Observable<Result<String, Error>?> {
        var scope: [String] = []
        scope.append("account_email")
        let result: Observable<Result<String, Error>?> = .init(nil)
        
        guard UserApi.isKakaoTalkLoginAvailable() == true else {
            result.value = .failure(LoginError.kakaoInstallNeed)
            return result
        }
        
        UserApi.shared.loginWithKakaoTalk { token, error in
            if error != nil {
                result.value = .failure(LoginError.kakaoRegisterError)
            } else {
                UserApi.shared.me { user, error in
                    guard let email = user?.kakaoAccount?.email else {
                        result.value = .failure(LoginError.kakaoEmaildataError)
                        return
                    }
                    result.value = .success(email)
                }
            }
        }
         
        return result
    }
}

enum LoginError: Error {
    case kakaoRegisterError
    case kakaoEmaildataError
    case kakaoInstallNeed
}
