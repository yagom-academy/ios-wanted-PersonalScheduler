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
    func register(_ authentication: Authentication, snsType: SNSType) -> AnyPublisher<Bool, Error>
    func deleteUser()
    func logout()
}

final class DefaultUserRepository: UserRepository {
    
    private let localStorage: LocalStorageService
    private let keychainStorage: KeyChainStorageService
    private let firestoreStorage: FirestoreStorageService
    private var cancellables: Set<AnyCancellable> = .init()
    
    init(
        localStorage: LocalStorageService = UserDefaults.standard,
        keychainStorage: KeyChainStorageService = KeyChainStorage.shard,
        firestoreStorage: FirestoreStorageService = FirestoreStorage.shared
    ) {
        self.localStorage = localStorage
        self.keychainStorage = keychainStorage
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
    
    func register(_ authentication: Authentication, snsType: SNSType) -> AnyPublisher<Bool, Error> {
        let newUser = User(
            userID: authentication.snsUserId,
            socialType: snsType.rawValue,
            name: authentication.snsUserName,
            profileURL: authentication.snsProfileUrl,
            schedules: []
        )
        localStorage.saveUser(newUser)
        return firestoreStorage.write(user: newUser)
    }
    
    func deleteUser() {
        guard let user = localStorage.getUser() else {
            return
        }
        localStorage.delete(key: .userInfo)
        keychainStorage.delete(key: .accessToken)
        keychainStorage.delete(key: .refreshToken)
        firestoreStorage.delete(user: user)
    }
    
    func logout() {
        localStorage.delete(key: .userInfo)
        keychainStorage.delete(key: .accessToken)
        keychainStorage.delete(key: .refreshToken)
    }
    
}

enum SNSType: String {
    case apple
    case facebook
    case kakao
}
