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
    
    private var loginService: LoginService?
    private var cancellable = Set<AnyCancellable>()
    
    func login(with loginService: LoginService) {
        self.loginService = loginService
        loginService.authorization()
            .sink {
                self.isSuccessSubject.send($0)
            }
            .store(in: &cancellable)
    }
    
    func createFirUser(id: String, password: String) {
        // TODO: - Open ID Connect
    }
    
    func faceBookLogin(
        from controller: UIViewController?,
        completion: @escaping (LoginManagerLoginResult) -> Void
    ) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile"], from: controller) { result, error in
            if error != nil {
                return
            }
            
            guard let result = result else { return }
            
            completion(result)
        }
    }
}

extension LoginViewModel: ASAuthorizationControllerDelegate {
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let user = credential.user
            
            print("user \(user)")
            
            if let email = credential.email {
                print("email \(email)")
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Error \(error)")
    }
}
