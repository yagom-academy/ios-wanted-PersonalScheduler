//
//  FirebaseError.swift
//  PersonalScheduler
//
//  Created by 곽우종 on 2023/01/11.
//

import Foundation

enum FirebaseError: Error {
    case readError
    case createError
}

extension FirebaseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .readError:
            return NSLocalizedString("읽기에 실패하엿습니다.", comment: "읽기 실패")
        case .createError:
            return NSLocalizedString("저장에 실패하엿습니다.", comment: "저장 실패")
        }
    }
}
