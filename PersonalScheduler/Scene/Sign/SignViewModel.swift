//
//  SignViewModel.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/11.
//

import Foundation
import AuthenticationServices

protocol SignViewModelInput {
    func autoLogInCheck()
    func didTapKakaoLoginButton()
    func didTapAppleLoginButton()
    func didTapFaceBookLoginButton()
}

protocol SignViewModelOutput {
    var error: Observable<String?> { get }
    var goToListScene: Observable<Bool?> { get }
}

protocol SignViewModellType: SignViewModelInput, SignViewModelOutput { }

final class SignViewModel: SignViewModellType {
    
    private let authUseCase: AuthUseCase
    private let userUseCase: UserUseCase
    private var loginTask: Task<Void, Error>?
    private var autoSignTask: Task<Void, Error>?
    
    init() {
        self.authUseCase = AuthUseCase()
        self.userUseCase = UserUseCase()
    }
    
    /// Output
    
    var error: Observable<String?> = Observable(nil)
    var goToListScene: Observable<Bool?> = Observable(nil)
    
    /// Input
    
    func autoLogInCheck() {
        self.autoSignTask = Task.detached(operation: {
            do {
                let kakaoResult = try await self.authUseCase.checKakaoAutoSign()
                if kakaoResult {
                    self.goToListScene.value = true
                } else {
                    let appleResult = try await self.authUseCase.checAppleAutoSign()
                    if appleResult {
                        self.goToListScene.value = true
                    }
                }
            }
            catch {
                self.error.value = error.localizedDescription
            }
        })
        autoSignTask?.cancel()
    }
    
    
    func didTapKakaoLoginButton() {
        self.loginTask = Task.detached(operation: {
            do {
                try await self.authUseCase.login(authType: .kakao)
                try await self.userUseCase.setUserDocumentation()
                self.goToListScene.value = true
            }
            catch {
                self.error.value = error.localizedDescription
            }
        })
        loginTask?.cancel()
    }
    
    func didTapAppleLoginButton() {
        self.loginTask = Task.detached(operation: {
            do {
                try await self.authUseCase.login(authType: .apple)
                try await self.userUseCase.setUserDocumentation()
                self.goToListScene.value = true
            }
            catch {
                self.error.value = error.localizedDescription
            }
        })
        loginTask?.cancel()
    }
    
    func didTapFaceBookLoginButton() {
        // authUseCase facebook
    }
    
    func getAppleAuthorizationController() -> ASAuthorizationController {
        return authUseCase.appleAuthRespository.authorizationController
    }
}

