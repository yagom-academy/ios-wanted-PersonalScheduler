//
//  LoginView.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/09.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            Text(loginViewModel.isLoggedIn.description)
            
            Button {
                loginViewModel.kakaoLogIn()
            } label: {
                Image(uiImage: UIImage(named: "KakoLoginImageButton")!)
            }
            Button {
                loginViewModel.kakaoLogout()
            } label: {
                Text("카카오 로그아웃")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
