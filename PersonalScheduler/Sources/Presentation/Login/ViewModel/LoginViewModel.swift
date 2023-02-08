//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import AuthenticationServices
import Combine
import FirebaseAuth
import FacebookLogin

class LoginViewModel: NSObject {
    private var loginRepository: LoginRepository?
    private var cancellable = Set<AnyCancellable>()
    @Published var isSuccess: Bool = false
    
    func login(with repository: LoginRepository) {
        self.loginRepository = repository
        
        self.loginRepository?.login()
            .sink { self.isSuccess = $0 }
            .store(in: &cancellable)
    }
}

extension LoginViewModel: ASAuthorizationControllerDelegate {
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        switch authorization.credential {
        case let appleIdCredential as ASAuthorizationAppleIDCredential:
            if let _ = appleIdCredential.email, let _ = appleIdCredential.fullName {
                print("Login with apple good")
                isSuccess = true
            } else {
                print("Fucking no")
                isSuccess = true
            }
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Error \(error)")
        isSuccess = false
    }
}
