//
//  FirebaseAuthService.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/12.
//

import FirebaseAuth

final class FirebaseAuthService {
    
    func createUser(email: String, password: String) async throws -> AuthDataResult? {
        do {
            let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
            return authDataResult
        } catch {
            print(error)
            return nil
        }
    }
    
    func signIn(email: String, password: String) async throws -> AuthDataResult? {
        do {
            let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
            return authDataResult
        } catch {
            print(error)
            return nil
        }
    }
}

enum FirebaseAuthServiceError: Error {
    case createUserError
    case signInError
}
