//
//  SignInRepositoryProtocol.swift
//  PersonalScheduler
//
//  Created by TORI on 2023/01/13.
//

import Foundation
import FirebaseAuth

protocol SignInRepositoryProtocol {
    func appleIDAuthorization(completion: @escaping (Result<AuthDataResult?, Error>) -> Void)
}
