//
//  OnboardingViewModel.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/10.
//

import UIKit

final class OnboardingViewModel {

    private let oAuthLoginUseCase = OAuthLoginUseCase()

    var onboardingCardImages = [UIImage(systemName: "person"), UIImage(systemName: "star"), UIImage(systemName: "person")]

    func appleLoginButtonTapped() {
        oAuthLoginUseCase.execute(loginType: .apple) { result in
            switch result {
            case .success:
                print("success")
            case .failure(let error):
                print(error)
            }
        }
    }

    func kakaoLoginButtonTapped() {
        oAuthLoginUseCase.execute(loginType: .kakao) { result in
            switch result {
            case .success:
                print("success")
            case .failure(let error):
                print(error)
            }
        }
    }

    func naverLoginButtonTapped() {
        oAuthLoginUseCase.execute(loginType: .apple) { result in
            switch result {
            case .success:
                print("success")
            case .failure(let error):
                print(error)
            }
        }
    }
}
