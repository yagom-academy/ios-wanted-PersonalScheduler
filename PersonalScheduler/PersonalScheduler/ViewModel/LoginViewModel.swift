//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/09.
//

import Foundation
import FirebaseAuth

final class LoginViewModel: ObservableObject {
    
    enum LoginResultAlert {
        case success, fail, normal
    }
    
    private let firebaseLoginManager = FirebaseLoginManager()
    private let kakaoLoginManager = KakaoLoginManager()
    
    @Published var isLoggedIn: Bool = false
    @Published var isActiveAlert: Bool = false
    @Published var accountUID: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    @Published var loginResultAlert: LoginResultAlert = .normal

    func firebaseLogin() {
        loginResultAlert = .normal
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                self?.errorMessage = error.localizedDescription
                self?.loginResultAlert = .fail
                return
            }
            guard let user = result?.user else { return }
            self?.accountUID = user.uid
            self?.loginResultAlert = .success
        }
        isActiveAlert.toggle()
    }
    
    @MainActor
    func kakaoLogIn() {
        Task {
            if await kakaoLoginManager.handleLogin(completion: { [weak self] data in
                self?.accountUID = data
                self?.isLoggedIn = true
            }) {
                isLoggedIn = false
            }
        }
    }
    
}
