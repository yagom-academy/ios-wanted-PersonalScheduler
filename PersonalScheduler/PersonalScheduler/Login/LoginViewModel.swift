//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/09.
//

import Foundation
import FirebaseAuth
import FacebookCore
import FacebookLogin

final class LoginViewModel: ObservableObject {
    
    enum LoginResultAlert {
        case success, fail, normal
    }
    
    private let firebaseLoginManager = FirebaseLoginManager()
    private let kakaoLoginManager = KakaoLoginManager()
    
    @Published var isAutoLogin: Bool = true
    @Published var isCheckLogin: Bool = false
    @Published var isActiveAlert: Bool = false
    @Published var accountUID: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    @Published var loginResultAlert: LoginResultAlert = .normal
    
    func checkAutoLoginInfo() {
        isAutoLogin = UserDefaults.standard.bool(forKey: UserInfoData.isAutoLogin)
        if isAutoLogin {
            if Auth.auth().currentUser?.uid != nil {
                self.accountUID = Auth.auth().currentUser?.uid ?? ""
                self.loginResultAlert = .success
                isActiveAlert = true
            }
        }
    }
    
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
        isActiveAlert = true
    }
    
    @MainActor
    func kakaoLogin() {
        Task {
            if await kakaoLoginManager.handleLogin(completion: { [weak self] result in
                switch result {
                case .success(let user):
                    self?.accountUID = user.uid
                    self?.isCheckLogin = true
                    
                case .failure(let error):
                    print("Error : \(error.localizedDescription)")
                    self?.errorMessage = error.localizedDescription
                    self?.loginResultAlert = .fail
                }
            }) { }
        }
    }
    
    func facebookLogin() {
        firebaseLoginManager.loginWithFacebook { [weak self] result in
            switch result {
            case .success(let user):
                self?.accountUID = user.uid
                self?.isCheckLogin = true
                
            case .failure(let error):
                print("Error : \(error.localizedDescription)")
                self?.errorMessage = error.localizedDescription
                self?.loginResultAlert = .fail
            }
        }
    }
    
}
