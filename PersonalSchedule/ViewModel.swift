//
//  ViewModel.swift
//  PersonalSchedule
//
//  Created by seohyeon park on 2023/01/12.
//

import Foundation
import Combine
import KakaoSDKUser
import FacebookLogin

class ViewModel: ObservableObject {
    @Published var isLogin = false
    @Published var showingAlert = false
    @Published var schedule = Dummy()
    @Published var facebookToken = ""
    @Published var facebookname = ""
    @Published var facebookemail = ""

    func handleFacebookLogin() {
        
        LoginManager().logIn(permissions: [.publicProfile, .email]) { result in
            
            switch result {
            case .success(granted: _ , declined: _, token: _):
                print("success")
                self.facebookToken = AccessToken.current?.tokenString ?? ""

                let connection = GraphRequestConnection()
                connection.add(GraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"], tokenString: self.facebookToken, version: Settings.defaultGraphAPIVersion, httpMethod: .get)) { connection, values, error in
                    if let res = values {
                        if let response = res as? [String: Any] {
                            
                            if let userId = response["id"] as? String {
                                self.facebookToken = userId
                            }
                            
                            if let name = response["name"] as? String {
                                self.facebookname = name
                            }
                            
                            if let email = response["email"] as? String {
                                self.facebookemail = email
                            }
                        }
                    }
                }
                connection.start()
                
                
            case .failed(let error):
                print(error.localizedDescription)
            case .cancelled:
                print("Cancelled")
            }
            
        }
    }
    
    @MainActor
    func handleKakaoLogin() {
        Task {
            if (UserApi.isKakaoTalkLoginAvailable()) {
                isLogin = await handleLoginWithKakaoTalkApp()
            } else {
                isLogin = await handleLoginWithKakaoAccount()
            }
            
            if isLogin {
                showingAlert = false
            } else {
                showingAlert = true
            }
        }
    }
    
    func kakaoLogout() async -> Bool {
        let isLoggedOut = await Task {
            return await handleKakaoLogout()
        }.value

        return isLoggedOut
    }
    
    @MainActor
    private func handleLoginWithKakaoTalkApp() async -> Bool {
        await withCheckedContinuation({ continuation in
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
        })
    }
    
    @MainActor
    private func handleLoginWithKakaoAccount() async -> Bool {
        await withCheckedContinuation({ continuation in
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
        })
        
    }

    @MainActor
    private func handleKakaoLogout() async -> Bool {
        await withCheckedContinuation({ continuation in
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("logout() success.")
                    continuation.resume(returning: true)
                }
            }
        })
    }
}
