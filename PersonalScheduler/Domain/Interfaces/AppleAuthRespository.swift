//
//  AppleAuthRespository.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/13.
//

import Foundation
import AuthenticationServices

protocol AppleAuthRespository {
    var authorizationController: ASAuthorizationController { get set }
    
    func loginWithApple() async throws -> String
    func checkAutoSign(userId: String) async throws -> Bool
}
