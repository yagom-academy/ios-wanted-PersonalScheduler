//
//  KeyChainAccount.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/13.
//

import Foundation

enum KeyChainAccount {
    case accessToken
    case userId
    
    var description: String {
        return String(describing: self)
    }
    
    var keyChainClass: CFString {
        switch self {
        case .accessToken:
            return kSecClassGenericPassword
        case .userId:
            return kSecClassInternetPassword
        }
    }
}
