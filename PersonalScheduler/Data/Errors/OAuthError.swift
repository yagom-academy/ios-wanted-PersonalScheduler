//
//  OAuthError.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/10.
//

import Foundation

enum OAuthError: LocalizedError {
    case identityTokenFetchFailed
    case dataSerializeFailed
    case noLoginRequestSended
}
