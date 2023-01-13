//
//  KakaoAuthRepository.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/13.
//

import Foundation

protocol KakaoAuthRepository {
    func isKakaoTalkLoginAvailable() async throws -> String
    func autoLogInCheck() async throws -> Bool
    func userId() async throws -> Int64
}
