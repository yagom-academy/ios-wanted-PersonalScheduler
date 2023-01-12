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

    func appleLoginButtonTapped() {
        oAuthLoginUseCase.execute(loginType: .apple) { result in
            switch result {
            case .success(let authResult):
                self.saveUID(authResult: authResult)
                print("success")
            case .failure(let error):
                print(error)
            }
        }
    }

    func kakaoLoginButtonTapped() {
        oAuthLoginUseCase.execute(loginType: .kakao) { result in
            switch result {
            case .success(let authResult):
                self.saveUID(authResult: authResult)
                print("success")
            case .failure(let error):
                print(error)
            }
        }
    }

    func naverLoginButtonTapped() {
        oAuthLoginUseCase.execute(loginType: .apple) { result in
            switch result {
            case .success(let authResult):
                self.saveUID(authResult: authResult)
                print("success")
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension OnboardingViewModel {
    private func saveUID(authResult: AuthDataResult?) {
        if let authResult = authResult {
            UserDefaults.standard.set(authResult.user.uid, forKey: "uid")
        }
    }
}
