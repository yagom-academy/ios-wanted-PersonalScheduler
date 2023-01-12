//
//  UserRepository.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/11.
//

import Foundation
import Combine

protocol UserRepository {
    func getRemoteUserInfo(authentication: Authentication) -> AnyPublisher<User, Error>
    func getLocalUserInfo() -> User?
    func localUpdate(user: User)
    func register(_ authatication: Authentication, snsType: SNSType) -> AnyPublisher<Bool, Error>
    func delete()
}

final class DefaultUserRepository: UserRepository {
    
    private let localStorage: LocalStorageService
    private let firestoreStorage: FirestoreStorageService
    private var cancellables: Set<AnyCancellable> = .init()
    
    init(
        localStorage: LocalStorageService = UserDefaults.standard,
        firestoreStorage: FirestoreStorageService = FirestoreStorage.shared
    ) {
        self.localStorage = localStorage
        self.firestoreStorage = firestoreStorage
    }
    
    func getRemoteUserInfo(authentication: Authentication) -> AnyPublisher<User, Error> {
        return firestoreStorage.read(userID: authentication.snsUserId)
    }
    
    func getLocalUserInfo() -> User? {
        return localStorage.getUser()
    }
    
    func localUpdate(user: User) {
        localStorage.saveUser(user)
    }
    
    func register(_ authatication: Authentication, snsType: SNSType) -> AnyPublisher<Bool, Error> {
        let newUser = User(
            userID: authatication.snsUserId,
            socialType: snsType.rawValue,
            name: authatication.snsUserName,
            profileURL: authatication.snsProfileUrl,
            schedules: []
        )
        localStorage.saveUser(newUser)
        return firestoreStorage.write(user: newUser)
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
