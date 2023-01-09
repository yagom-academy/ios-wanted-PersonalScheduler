//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/09.
//

import Foundation

final class LoginViewModel: ObservableObject {
    
    let kakaoLoginManager = KakaoLoginManager()
    
    @Published var isLoggedIn: Bool = false
    
    @MainActor
    func kakaoLogIn() {
        Task {
            if await kakaoLoginManager.handleKakaoLogin() {
                isLoggedIn = true
            } else {
                isLoggedIn = false
            }
        }
        print(isLoggedIn)
    }
    
    @MainActor
    func kakaoLogout() {
        Task {
            if await kakaoLoginManager.handleKakaoLogout() {
                isLoggedIn = false
            } else {
                isLoggedIn = true
            }
        }
        print(isLoggedIn)
    }

}
