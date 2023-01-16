//
//  SignInUseCase.swift
//  PersonalScheduler
//
//  Created by TORI on 2023/01/13.
//

import Foundation

final class SignInUseCase {
    
    private let repository: SignInRepositoryProtocol!
    
    init(repository: SignInRepositoryProtocol = SignInRepository()) {
        self.repository = repository
    }
    
    func appleSignIn() {
        repository.appleIDAuthorization { [weak self] result in
            switch result {
            case let .success(data):
                guard let data = data else { return }
                self?.saveUserInKeychain(data.user.uid)
            case let .failure(error):
                print(#function)
                print(error.localizedDescription)
            }
        }
    }
    
    private func saveUserInKeychain(_ uid: String) {
        do {
            try KeychainItem(service: "com.wanted.PersonalScheduler", account: "uid").saveItem(uid)
        } catch {
            print("Unable to save uid to keychain.")
        }
    }
}
