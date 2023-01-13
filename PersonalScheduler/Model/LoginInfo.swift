//
//  KakaoLoginInfo.swift
//  PersonalScheduler
//
//  Created by 곽우종 on 2023/01/11.
//

import Foundation

enum LoginType: String {
    case kakao
    case facebook
}

struct LoginInfo: FirebaseDatable {
    var userId: String
    var id: String
    var loginType: String
    
    init(userId: String = UUID().uuidString, id: String, loginType: LoginType) {
        self.userId = userId
        self.id = id
        self.loginType = loginType.rawValue
    }
    
    var detailPath: [String] {
        var newPath = LoginInfo.path
        newPath.append(loginType)
        newPath.append(id)
        return newPath
    }
    
    static var path: [String] = ["Users"]
}
