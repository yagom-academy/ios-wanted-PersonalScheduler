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
            ScheduleListView()
        } else {
            VStack {
                Text("Personal Schedular")
                    .font(.system(size: 35))
                    .fontWeight(.heavy)
                
                Image("checklist")
                    .resizable()
                    .scaledToFit()

                Button {
                    loginViewModel.loginButtonTapped(serviceName: loginViewModel.kakaoOAuthService)
                } label: {
                    Image("kakao_login_medium_narrow")
                }
                .offset(y: 100)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginView(loginViewModel: LoginViewModel())
    }
    
}
