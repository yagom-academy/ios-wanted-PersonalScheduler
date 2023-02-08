//
//  SocialLoginRepository.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import FirebaseAuth

final class SocialLoginRepository: LoginRepository {
    private let service: LoginService
    
    init(service: LoginService) {
        self.service = service
    }
    
    func login() -> AnyPublisher<Bool, Never> {
        return service.login()
    }
}
