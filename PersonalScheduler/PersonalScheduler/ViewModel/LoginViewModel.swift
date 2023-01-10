//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/09.
//

import Foundation

final class LoginViewModel: ObservableObject {
    
    private let firebaseLoginManager = FirebaseLoginManager()
    private let kakaoLoginManager = KakaoLoginManager()
    
    @Published var isLoggedIn: Bool = false
    @Published var uid = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    @MainActor
    func firebaseLogin() {
        firebaseLoginManager.handleLogin(email: email, password: password, completion: { [weak self] data in
            self?.uid = data
        })
    }
    
    @MainActor
    func kakaoLogIn() {
        Task {
            if await kakaoLoginManager.handleLogin(completion: { [weak self] data in
                self?.uid = data
            }) {
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
