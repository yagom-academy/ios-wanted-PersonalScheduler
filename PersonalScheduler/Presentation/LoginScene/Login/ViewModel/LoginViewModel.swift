//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

import Foundation
import FirebaseAuth
import FacebookCore
import UIKit

struct LoginViewModelActions {
    let successLogin: (String) -> Void
    let successKakaoLogin: (String) -> Void
    let successFacebookLogin: (String) -> Void
    let signinButtonTapped: () -> Void
}

protocol LoginViewModelInput {
    func validateLoginInfo(_ loginInfo: LoginInfo) async throws
    func signinButtonTapped()
    func kakaoLogoButtonTapped()
    func facebookLoginButtonTapped(in vc: UIViewController)
}

protocol LoginViewModelOutput {}

protocol LoginViewModel: LoginViewModelInput, LoginViewModelOutput {}

final class DefaultLoginViewModel: LoginViewModel {
    private let actions: LoginViewModelActions?
    private let kakaoLoginUseCase: KakaoLoginUseCase
    private let facebookLoginUseCase: FacebookLoginUseCase
    private let firebaseAuthUseCase: FirebaseAuthUseCase
    
    init(
        actions: LoginViewModelActions? = nil,
        kakaoLoginUseCase: KakaoLoginUseCase,
        facebookLoginUseCase: FacebookLoginUseCase,
        firebaseAuthUseCase: FirebaseAuthUseCase
    ) {
        self.actions = actions
        self.kakaoLoginUseCase = kakaoLoginUseCase
        self.facebookLoginUseCase = facebookLoginUseCase
        self.firebaseAuthUseCase = firebaseAuthUseCase
    }
    
    func validateLoginInfo(_ loginInfo: LoginInfo) async throws {
        do {
            let userUID = try await firebaseAuthUseCase.fetchUserUID(from: loginInfo)
            actions?.successLogin(userUID)
        } catch {
            print(String(describing: error))
            throw error
        }
    }
    
    func signinButtonTapped() {
        actions?.signinButtonTapped()
    }
    
    func kakaoLogoButtonTapped() {
        kakaoLoginUseCase.login { email in
            guard let email = email else { return }
            self.actions?.successKakaoLogin(email)
        }
    }
    
    func facebookLoginButtonTapped(in vc: UIViewController) {
        facebookLoginUseCase.login(in: vc) { [self] in
            facebookLoginUseCase.fetchEmail { [self] email in
                guard let email = email else { return }
                actions?.successFacebookLogin(email)
            }
        }
    }
}
