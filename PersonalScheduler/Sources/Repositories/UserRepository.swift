//
//  UserRepository.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/11.
//

import Foundation

protocol UserRepository {
    func register(_ authatication: Authentication, snsType: SNSType)
    func delete()
    func myInfo() -> User?
}

final class DefaultUserRepository: UserRepository {
    
    private let localStorage: LocalStorageService
    
    init(localStorage: LocalStorageService = UserDefaults.standard) {
        self.localStorage = localStorage
    }
    
    func register(_ authatication: Authentication, snsType: SNSType) {
        let newUser = User(
            userID: authatication.snsUserId,
            socialType: snsType.rawValue,
            name: authatication.snsUserName,
            profileURL: authatication.snsProfileUrl,
            schedules: []
        )
        localStorage.saveUser(newUser)
    }
    
    func delete() {
        localStorage.delete(key: .userInfo)
    }
    
    func myInfo() -> User? {
        localStorage.getUser()
    }
}

enum SNSType: String {
    case apple
    case facebook
    case kakao
}
