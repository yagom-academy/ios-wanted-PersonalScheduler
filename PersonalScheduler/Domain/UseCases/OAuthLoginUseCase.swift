//
//  OAuthLoginUseCase.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/10.
//

import Foundation
import FirebaseAuth

final class OAuthLoginUseCase {

    private let repository: OAuthRepositoryInterface

    init(repository: OAuthRepositoryInterface) {
        self.repository = repository
    }

    func execute(loginType: OAuthType, completion: @escaping (Result<AuthDataResult?, Error>) -> Void) {
        repository.loginWith(loginType) { result in
            completion(result)
        }
    }
}
