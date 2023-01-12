//
//  LoginView.swift
//  PersonalScheduler
//
//  Created by minsson on 2023/01/12.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var loginViewModel: LoginViewModel
    
    var body: some View {
        if loginViewModel.isLoginFinished {
            scheduleListView
        } else {
            VStack {
                Button("카카오 로그인") {
                    loginViewModel.loginButtonTapped(serviceName: loginViewModel.kakaoOAuthService)
                }
                
                Button("로그아웃") {
                    loginViewModel.logoutButtonTapped(serviceName: loginViewModel.kakaoOAuthService)
                }
            }
        }
    }
    
    var scheduleListView: some View {
        Text(loginViewModel.firebaseID)
    }
    
}

struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginView(loginViewModel: LoginViewModel())
    }
}
