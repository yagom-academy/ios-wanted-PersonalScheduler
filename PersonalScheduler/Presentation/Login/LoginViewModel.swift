//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Created by TORI on 2023/01/12.
//

import Foundation

final class LoginViewModel {
    
    private let service: AppleAuthorityService!
    
    init(service: AppleAuthorityService = AppleAuthorityService()) {
        self.service = service
    }
    
    func appleIDAuthorization() {
        service.performAuthorizationRequest()
    }
}
