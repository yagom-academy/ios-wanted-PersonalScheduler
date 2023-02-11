//
//  ApiError.swift
//  PersonalScheduler
//
//  Created by Mangdi on 2023/02/12.
//

import Foundation

enum ApiError: CustomStringConvertible {
    case loginError
    case logoutError
    case firebaseFetchError
    case firebaseFetchDataNilError
    case firebaseFetchDataWrongTypeError

    var description: String {
        switch self {
        case .loginError:
            return "로그인 에러가 발생했습니다."
        case .logoutError:
            return "로그아웃 에러가 발생했습니다."
        case .firebaseFetchError:
            return "Firbase에서 데이터를 받아오는도중 알 수 없는 에러가 발생했습니다."
        case .firebaseFetchDataNilError:
            return "Firebase에 데이터가 비어있습니다."
        case .firebaseFetchDataWrongTypeError:
            return "Firebase에서 받은 데이터 타입이 잘못되었습니다."
        }
    }


}
