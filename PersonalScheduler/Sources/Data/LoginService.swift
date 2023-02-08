//
//  LoginService.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import FirebaseAuth

protocol LoginService {
    func login(with credential: AuthCredential) -> AnyPublisher<Bool, Never>
}
