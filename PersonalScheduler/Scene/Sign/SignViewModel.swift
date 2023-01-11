//
//  SignViewModel.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/11.
//

import Foundation

protocol SignViewModelInput {
    func autoLogInCheck()
    func didTapKakaoLoginButton()
    func didTapAppleLoginButton()
    func didTapFaceBookLoginButton()
}

protocol SignViewModelOutput {
    var error: Observable<String?> { get }
}

protocol SignViewModellType: SignViewModelInput, SignViewModelOutput { }

final class SignViewModel: SignViewModellType {
    
    private let authUseCase: AuthUseCase
    private var loginTask: Task<Void, Error>?
    
    init() {
        self.authUseCase = AuthUseCase()
    }
    
    /// Output
    
    var error: Observable<String?> = Observable(nil)
    
    /// Input
    
    func autoLogInCheck() {
        Task {
            do {
                let result = try await authUseCase.autoLoginCheck()
                if result {
                    print("다음 화면으로 넘어가기")
                }
            }
            catch {
                self.error.value = error.localizedDescription
            }
        }
    }
    
    
    func didTapKakaoLoginButton() {
        self.loginTask = Task {
            do {
                try await authUseCase.login(authType: .kakao)
                print("다음 화면으로 넘어가기")
            }
            catch {
                self.error.value = error.localizedDescription
            }
        }
        loginTask?.cancel()
    }
    
    func didTapAppleLoginButton() {
        // authUseCase apple
    }
    
    func didTapFaceBookLoginButton() {
        // authUseCase facebook
    }
}

