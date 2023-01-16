//
//  LoginError.swift
//  PersonalScheduler
//
//  Created by 우롱차 on 2023/01/11.
//

import Foundation

enum LoginError: Error {
    case kakaoLodedError
    case facebookLoadedError
}

extension LoginError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .kakaoLodedError:
            return NSLocalizedString("카카오 계정 연동에 실패하였습니다", comment: "카카오 연동 실패")
        case .facebookLoadedError:
            return NSLocalizedString("페이스북 계정 연동에 실패하였습니다", comment: "페이스북 연동 실패")
        }
    }
}
