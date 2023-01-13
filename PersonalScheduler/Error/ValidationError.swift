//
//  ValidationError.swift
//  PersonalScheduler
//
//  Created by 우롱차 on 2023/01/13.
//

import Foundation

enum ValidationError: Error {
    case titleIsEmpty
    case contentsIsTooLong
    case dateIsEmpty
}

extension ValidationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .titleIsEmpty:
            return NSLocalizedString("제목이 비었습니다.", comment: "제목 오류")
        case .contentsIsTooLong:
            return NSLocalizedString("내용이 너무 깁니다.(500자 이하)", comment: "내용 오류")
        case .dateIsEmpty:
            return NSLocalizedString("날짜를 선택해주세요.", comment: "날짜 오류")
        }
    }
}


