//
//  LoginService.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine

protocol LoginService {
    func authorization() -> AnyPublisher<Bool, Never>
}
