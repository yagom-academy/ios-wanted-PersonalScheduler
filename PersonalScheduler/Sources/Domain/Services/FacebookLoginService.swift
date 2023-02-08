//
//  FacebookLoginService.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import FacebookLogin

final class FacebookLoginService: LoginService {
    @Published var isSuccess = false
    
    func authorization() -> AnyPublisher<Bool, Never> {
        login()
        return AnyPublisher($isSuccess)
    }
    
    func login() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile"], from: nil) { result, error in
            guard error == nil else {
                self.isSuccess = false
                return
            }
            
            guard let result = result else { return }
            
            if result.token?.isExpired == false {
                self.getProfile()
            }
        }
    }
    
    func getProfile() {
        Profile.loadCurrentProfile { profile, error in
            guard let firstName = profile?.firstName else {
                self.isSuccess = false
                return
            }
            
            self.isSuccess = true
        }
    }
}
