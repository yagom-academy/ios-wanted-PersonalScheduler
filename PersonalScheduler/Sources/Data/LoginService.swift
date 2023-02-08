//
//  LoginService.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine

protocol LoginService {
    var isSuccess: PassthroughSubject<Bool, Never> { get }
    
    func login()
}
