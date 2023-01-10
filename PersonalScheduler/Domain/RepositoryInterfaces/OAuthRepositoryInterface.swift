//
//  OAuthRepositoryInterface.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/10.
//

import Foundation
import FirebaseAuth

enum OAuthType {
    case apple
    case kakao
    case naver
}

protocol OAuthRepositoryInterface {
    func loginWith(_ type: OAuthType, completion: @escaping (Result<AuthDataResult?, Error>) -> Void)
}
