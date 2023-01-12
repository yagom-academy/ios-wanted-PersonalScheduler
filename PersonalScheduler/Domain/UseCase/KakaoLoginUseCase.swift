//
//  KakaoLoginUseCase.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/11.
//

struct KakaoLoginUseCase {
    private let kakaoLoginService = KakaoLoginService()
    
    func login(_ completion: ((String?) -> Void)? = nil) {
        kakaoLoginService.login { _ in
            kakaoLoginService.searchUserInfo { user in
                completion?(user?.kakaoAccount?.email)
            }
        }
    }
}
