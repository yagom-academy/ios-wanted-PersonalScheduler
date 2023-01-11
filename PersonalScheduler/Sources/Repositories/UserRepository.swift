//
//  UserRepository.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/11.
//

import Foundation

protocol UserRepository {
    func myInfo() -> User?
    func register(_ authatication: Authentication, snsType: SNSType)
    func delete()
}

final class DefaultUserRepository: UserRepository {
    
    private let localStorage: LocalStorageService
    private let firestoreStorage: FirestoreStorageService
    
    init(
        localStorage: LocalStorageService = UserDefaults.standard,
        firestoreStorage: FirestoreStorageService = FirestoreStorage.shared
    ) {
        self.localStorage = localStorage
        self.firestoreStorage = firestoreStorage
    }
    
    func myInfo() -> User? {
        localStorage.getUser()
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
        firestoreStorage.write(user: newUser)
    }
    
    func delete() {
        guard let user = localStorage.getUser() else {
            return
        }
        localStorage.delete(key: .userInfo)
        firestoreStorage.delete(user: user)
    }
    
}

enum SNSType: String {
    case apple
    case facebook
    case kakao
}
