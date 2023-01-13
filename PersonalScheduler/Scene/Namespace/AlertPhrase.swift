//
//  AlertPhrase.swift
//  PersonalScheduler
//
//  Created by Judy on 2023/01/13.
//

enum AlertPhrase {
    case kakaoLoginFailed
    case facebookLoginFailed
    case insufficientInput
    case impossibleDate
    case excessContent
    
    var title: String {
        switch self {
        case .kakaoLoginFailed, .facebookLoginFailed:
            return "로그인 실패"
        case .insufficientInput, .impossibleDate, .excessContent:
            return "일정 저장 불가"
        }
    }
    
    var message: String {
        switch self {
        case .kakaoLoginFailed:
            return "카카오 로그인에 실패했습니다."
        case .facebookLoginFailed:
            return "페이스북 로그인에 실패했습니다."
        case .insufficientInput:
            return "모든 항목을 입력해주세요."
        case .impossibleDate:
            return "종료일이 시작일 이전일 수 없습니다."
        case .excessContent:
            return "내용은 500자 이하로만 가능합니다."
        }
    }
}
