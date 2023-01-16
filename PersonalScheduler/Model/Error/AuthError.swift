//
//  AuthError.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/11.
//

import Foundation

enum AuthError: Error {
    case notFoundCurrentUser
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFoundCurrentUser:
            return NSLocalizedString("사용자 인증 에러: 로그인한 이력이 없습니다.", comment: "NotFoundCurrentUser")
        }
    }
}
