//
//  LoginRepository.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import Foundation
import Combine

protocol LoginRepository: AnyObject {
    func login() -> AnyPublisher<Bool, Never>
}
