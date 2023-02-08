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
    var isSuccessSubject: CurrentValueSubject<Bool, Never> = CurrentValueSubject(false)
    private var cancellable = Set<AnyCancellable>()
    
    func login(with loginService: LoginService) {
        loginService.isSuccess
            .sink {
                self.isSuccessSubject.send($0)
            }
            .store(in: &cancellable)
        
        loginService.login()
    }
    
    func createFirUser(id: String, password: String) {
        // TODO: - Open ID Connect
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
                self.isSuccessSubject.send(true)
            } else {
                print("Fucking no")
                self.isSuccessSubject.send(true)
            }
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Error \(error)")
        self.isSuccessSubject.send(false)
    }
}
