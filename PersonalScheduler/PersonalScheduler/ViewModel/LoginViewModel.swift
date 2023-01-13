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
    
    @Published var isAutoLogin = true
    @Published var isLoggedIn: Bool = false
    @Published var isActiveAlert: Bool = false
    @Published var accountUID: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    @Published var loginResultAlert: LoginResultAlert = .normal
    
    func checkAutoLoginInfo() {
        isAutoLogin = UserDefaults.standard.bool(forKey: UserInfoData.isAutoLogin)

        if isAutoLogin {
            if let userId = UserDefaults.standard.string(forKey: UserInfoData.id) {
                self.email = userId
                self.password = UserDefaults.standard.string(forKey: UserInfoData.password) ?? ""
                
                firebaseLogin()
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
        isActiveAlert.toggle()
        
        if isAutoLogin {
            UserDefaults.standard.set(self.email, forKey: UserInfoData.id)
            UserDefaults.standard.set(self.password, forKey: UserInfoData.password)
        }
    }
    
    @MainActor
    func kakaoLogIn() {
        Task {
            if await kakaoLoginManager.handleLogin(completion: { [weak self] response in
                switch response {
                    
                case .success(let data):
                    self?.accountUID = data.uid
                    self?.isLoggedIn = true
                    if ((self?.isAutoLogin) != nil) {
                        UserDefaults.standard.set(data.email, forKey: UserInfoData.id)
                        UserDefaults.standard.set(data.password, forKey: UserInfoData.password)
                    }
                case .failure(_):
                    print("error")
                }
            }) {
                isLoggedIn = false
            }
        }
    }
    
    func facebookLogIn() {
        firebaseLoginManager.loginWithFacebook { [weak self] result in
            switch result {
            case .success(let user):
                self?.accountUID = user.uid
                self?.isLoggedIn = true
            case .failure(let error):
                print(error.localizedDescription)
                self?.isLoggedIn = false
            }
        }
    }
}
