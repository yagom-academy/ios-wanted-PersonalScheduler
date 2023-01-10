//
//  LoginInfo.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/10.
//

struct LoginInfo {
    let id: String
    let password: String
    
    func validate() throws {
        guard id.contains("@") && id.contains(".") else {
            throw LoginError.invalidEmail
        }
        guard password.count >= 6 else {
            throw LoginError.invalidPassword(number: password.count)
        }
    }
}
