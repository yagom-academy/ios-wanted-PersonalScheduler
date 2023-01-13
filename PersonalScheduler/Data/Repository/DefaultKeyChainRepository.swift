//
//  KeyChainRepository.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/13.
//

import Foundation

final class DefaultKeyChainRepository: KeyChainRepository {
    
    private let keyChainStorage = KeyChainStorage.shared
    
    init() {
    }
    
    func setUserId(_ data: String) async throws {
        try await keyChainStorage.create(account: .userId, data: data)
    }
    
    func setAccessToken(_ token: String) async throws {
        try await keyChainStorage.create(account: .accessToken, data: token)
    }
    
    func getUserId() async throws -> String {
        return try await keyChainStorage.read(account: .userId)
    }
    
    func getAccessToken() async throws -> String {
        return try await keyChainStorage.read(account: .accessToken)
    }
}

