//
//  FirebaseAuthUseCase.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/12.
//

struct FirebaseAuthUseCase {
    private let firebaseAuthService = FirebaseAuthService()
    
    func fetchUserEmail(from loginInfo: LoginInfo) async throws -> String {
        guard let authDataResult = try await firebaseAuthService.createUser(email: loginInfo.id, password: loginInfo.password) else {
            throw FirebaseAuthServiceError.createUserError
        }
        return authDataResult.user.email!
    }
    
    func fetchUserUID(from loginInfo: LoginInfo) async throws -> String {
        
        guard let authDataResult = try await firebaseAuthService.signIn(email: loginInfo.id, password: loginInfo.password) else {
            throw FirebaseAuthServiceError.signInError
        }
        return authDataResult.user.uid   
    }
}
