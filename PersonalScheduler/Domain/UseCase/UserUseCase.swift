//
//  UserUseCase.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/13.
//

import Foundation

final class UserUseCase {
    let fireStoreScehduleRepository: FireStoreRepository
    let keychainRepository: KeyChainRepository
    
    init() {
        self.fireStoreScehduleRepository = DefaultFireStoreRepository()
        self.keychainRepository = DefaultKeyChainRepository()
    }
    
    func setUserDocumentation() async throws {
        let userId = try await keychainRepository.getUserId()
        try await fireStoreScehduleRepository.setUserData(userId: userId)
    }
}
