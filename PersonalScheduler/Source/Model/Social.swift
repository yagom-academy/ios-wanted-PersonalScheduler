//
//  Social.swift
//  PersonalScheduler
//
//  Created by Kyo on 2023/02/08.
//

import Foundation

enum Social {
    case kakao
    case faceBook
    case apple
}

extension Social: CustomStringConvertible {
    var description: String {
        switch self {
        case .kakao:
            return "KAKAO"
        case .faceBook:
            return "FACEBOOK"
        case .apple:
            return "APPLE"
        }
    }
}
