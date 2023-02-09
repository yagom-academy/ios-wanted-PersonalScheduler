//
//  LoginRepository.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import Foundation
import Combine

enum LoginError: Error {
    case invalidToken
    case unReadCredential
    case unknown
}

protocol LoginRepository: AnyObject {
    var service: LoginService { get }
    func login(completion: @escaping (Result<Void, LoginError>) -> Void)
}
