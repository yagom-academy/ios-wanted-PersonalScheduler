//
//  OnboardingViewModel.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/10.
//

import UIKit
import FirebaseAuth

final class OnboardingViewModel {

    private let oAuthLoginUseCase = OAuthLoginUseCase()


    let onboardingCardTitles = [
        "일정을 관리해보세요",
        "일정을 추가해보세요",
        "꾹 눌러서 일정을 삭제할 수 있어요"
    ]
    let onboardingCardImages = [
        UIImage(named: "onboarding1"),
        UIImage(named: "onboarding2"),
        UIImage(named: "onboarding3")
    ]

    func appleLoginButtonTapped(completion: @escaping () -> Void) {
        oAuthLoginUseCase.execute(loginType: .apple) { result in
            switch result {
            case .success:
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }

    func kakaoLoginButtonTapped(completion: @escaping () -> Void) {
        oAuthLoginUseCase.execute(loginType: .kakao) { result in
            switch result {
            case .success:
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
}
