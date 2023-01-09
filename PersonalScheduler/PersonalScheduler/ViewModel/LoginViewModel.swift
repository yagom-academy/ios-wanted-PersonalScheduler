//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/09.
//

import Foundation

final class LoginViewModel: ObservableObject {
    
    private let kakaoLoginManager = KakaoLoginManager()
    
    @Published var isLoggedIn: Bool = false
    
    @MainActor
    func kakaoLogIn() {
        Task {
            if await kakaoLoginManager.handleLogin() {
                isLoggedIn = true
            } else {
                isLoggedIn = false
            }
        }
    }
    
    @MainActor
    func kakaoLogout() {
        Task {
            if await kakaoLoginManager.handleLogout() {
                isLoggedIn = false
            } else {
                isLoggedIn = true
            }
        }
    }
    
}
