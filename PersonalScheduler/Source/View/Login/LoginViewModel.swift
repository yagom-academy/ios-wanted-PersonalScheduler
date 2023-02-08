//  PersonalScheduler - LoginViewModel.swift
//  Created by zhilly on 2023/02/07

import Foundation
import KakaoSDKAuth
import KakaoSDKUser
import FirebaseAuth

final class LoginViewModel {
    
    // MARK: - Properties
    
    var userInfo: Observable<String?> = Observable(.init())
    
    // MARK: - Methods
    
    func tappedKakaoLoginButton() {
        if AuthApi.hasToken() {
            UserApi.shared.accessTokenInfo { accessTokenInfo, error in
                if let error = error {
                    print("카카오톡 토큰 가져오기 에러 \(error.localizedDescription)")
                    self.kakaoLogin()
                } else {
                    // 토큰 유효성 체크 성공 (필요 시 토큰 갱신)
                    self.setUserInfo()
                }
            }
        } else {
            kakaoLogin()
        }
    }
    
    private func kakaoLogin() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    self.setUserInfo()
                }
            }
        }
    }
    
    private func setUserInfo() {
        UserApi.shared.me() { (user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                self.userInfo.value = user?.kakaoAccount?.profile?.nickname
                
                guard let user = user,
                      let kakaoAccount = user.kakaoAccount,
                      let userEmail = kakaoAccount.email else {
                    print("User Email error")
                    return
                }
                
                let userID = String(describing: user.id)
                
                self.firebaseLogin(userEmail: userEmail, userID: userID)
            }
        }
    }
    
    func kakaoLogout() {
        UserApi.shared.logout { (error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
                self.userInfo.value = "로그아웃 되었습니다."
            }
        }
    }
    
    func firebaseLogin(userEmail: String, userID: String) {
        Auth.auth().createUser(withEmail: userEmail, password: userID) { result, error in
            if let error = error {
                print("DEBUG: 파이어베이스 사용자 생성 실패 \(error.localizedDescription)")
                Auth.auth().signIn(withEmail: userEmail, password: userID)
                //self.didSendEventClosure?(.close)
            } else {
                print("DEBUG: 파이어베이스 사용자 생성")
                //self.didSendEventClosure?(.showSignUp) // 회원가입 화면으로 이동
                //self.dismiss(animated: true) // 창닫기
            }
        }
    }
}
