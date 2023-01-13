//
//  KeyChainRepository.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/13.
//

import Foundation

protocol KeyChainRepository {
    func setUserId(_ data: String) async throws
    func setAccessToken(_ token: String) async throws
    func getUserId() async throws -> String
    func getAccessToken() async throws -> String
}
