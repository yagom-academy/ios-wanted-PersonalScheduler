//
//  FacebookLoginService.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import FacebookLogin

final class FacebookLoginService: LoginService {
    private var isSuccess: PassthroughSubject<Bool, Never> = PassthroughSubject()
    func login() -> AnyPublisher<Bool, Never> {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile"], from: nil) { result, error in
            guard error == nil else {
                self.isSuccess.send(false)
                return
            }
            
            guard let result = result else { return }
            
            if result.token?.isExpired == false {
                self.getProfile()
            }
        }
        
        return isSuccess.eraseToAnyPublisher()
    }
    
    func getProfile() {
        Profile.loadCurrentProfile { profile, error in
            guard let firstName = profile?.firstName else {
                self.isSuccess.send(false)
                return
            }
            
            self.isSuccess.send(true)
        }
    }
}
