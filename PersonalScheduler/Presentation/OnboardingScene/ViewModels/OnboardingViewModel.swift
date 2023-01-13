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

    var onboardingCardImages = [UIImage(systemName: "person"), UIImage(systemName: "star"), UIImage(systemName: "person")]

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

    func naverLoginButtonTapped(completion: @escaping () -> Void) {
        oAuthLoginUseCase.execute(loginType: .apple) { result in
            switch result {
            case .success:
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
}
