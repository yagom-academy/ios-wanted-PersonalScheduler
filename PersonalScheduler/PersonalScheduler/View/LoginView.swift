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

                GeometryReader { geometry in
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text("Go Create Account Page")
                            .foregroundColor(.white)
                            .frame(width: geometry.size.width, height: 40)
                    }
                    .background(Color.purple)
                }
                .frame(height: 40)
                .cornerRadius(10)
                
                Toggle(isOn: $loginViewModel.isAutoLogin) {
                    Text("자동 로그인 설정")
                }
                .onChange(of: loginViewModel.isAutoLogin) { value in
                    switch value {
                    case true:
                        UserDefaults.standard.set(true, forKey: UserInfoData.isAutoLogin)
                    case false:
                        UserDefaults.standard.set(false, forKey: UserInfoData.isAutoLogin)
                    }
                }
                
                Button {
                    loginViewModel.kakaoLogin()
                } label: {
                    Image(uiImage: UIImage(named: "KakoLoginImageButton")!)
                        .resizable()
                        .frame(width: 210, height: 50)
                }
                .padding(.top, 50)
                
                Button {
                    loginViewModel.facebookLogin()
                } label: {
                    FBLog()
                        .frame(width: 80, height: 50)
                }
                .padding(.bottom, 50)
 
            }
            .padding()
            .navigationTitle("Personal Scheduler")
            .navigationBarTitleDisplayMode(.large)
            .fullScreenCover(isPresented: $loginViewModel.isCheckLogin) {
                ScheduleListView(accountUID: loginViewModel.accountUID)
            }
            .alert(isPresented: $loginViewModel.isActiveAlert) {
                switch loginViewModel.loginResultAlert {
                case .success:
                    let alert = Alert(
                        title: Text("환영 합니다~"),
                        primaryButton: .default(Text("확인"), action: {
                            loginViewModel.isCheckLogin = true
                        }),
                        secondaryButton: .cancel()
                    )
                    return alert
                case .fail:
                    let alert = Alert(
                        title: Text("Error"),
                        message: Text(loginViewModel.errorMessage),
                        dismissButton: .cancel()
                    )
                    return alert
                case .normal:
                    let alert = Alert(
                        title: Text("Checking..."),
                        dismissButton: .cancel()
                    )
                    return alert
                }
            }
            .onAppear {
                loginViewModel.checkAutoLoginInfo()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
