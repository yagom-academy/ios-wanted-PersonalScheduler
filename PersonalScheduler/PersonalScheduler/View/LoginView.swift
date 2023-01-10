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
        NavigationView {
            VStack {
                Text("uid: " +
                     loginViewModel.uid)
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.top, 80)
                    .padding(.bottom, 50)
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("ID", text: $loginViewModel.email)
                    .padding()
                    .background(
                        Color(.systemGray6)
                    )
                    .cornerRadius(10)
                SecureField("Password", text: $loginViewModel.password)
                    .padding()
                    .background(
                        Color(.systemGray6)
                    )
                    .cornerRadius(10)
                
                GeometryReader { geometry in
                    Button {
                        loginViewModel.firebaseLogin()
                    } label: {
                        Text("Login")
                            .foregroundColor(.white)
                            .frame(width: geometry.size.width, height: 40)
                    }
                    .background(Color.blue)
                }
                .frame(height: 40)
                .cornerRadius(10)
                
                Button {
                    loginViewModel.kakaoLogIn()
                } label: {
                    Image(uiImage: UIImage(named: "KakoLoginImageButton")!)
                }
                .padding(.top, 50)
                
                NavigationLink {
                    SignUpView()
                } label: {
                    Text("Create Account")
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .padding()
            .navigationTitle("Personal Scheduler")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
