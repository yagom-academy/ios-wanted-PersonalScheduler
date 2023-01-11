//
//  LoginView.swift
//  PersonalScheduler
//
//  Created by minsson on 2023/01/12.
//

import SwiftUI

struct LoginView: View {
    
    let kakaoOAuthService = KakaoOAuthService()
    
    var body: some View {
        Button("카카오 로그인") {
            kakaoOAuthService.executeLogin()
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
