//
//  SignUpView.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/09.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var signUpViewModel = SignUpViewModel()
    
    @State var newEmail: String = ""
    @State var newPassword: String = ""
    
    var body: some View {
        VStack {
            Text("Welcom!\nCreate your Account")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom, 50)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("ID", text: $newEmail)
                .padding()
                .background(
                    Color(.systemGray6)
                )
                .cornerRadius(10)
            SecureField("Password", text: $newPassword)
                .padding()
                .background(
                    Color(.systemGray6)
                )
                .cornerRadius(10)
            
            Button {
                signUpViewModel.registerUser(email: newEmail, password: newPassword)
            } label: {
                Text("Create Account")
            }
            .padding()
        }
        .padding()
        .alert(isPresented: $signUpViewModel.isActiveAlert) {
            switch signUpViewModel.loginResultAlert {
            case .success:
                let alert = Alert(title: Text("Success"),
                                  message: Text("Welcom!!"),
                                  dismissButton: .cancel()
                )
                return alert
            case .fail:
                let alert = Alert(title: Text("Error"),
                                  message: Text(signUpViewModel.errorMessage),
                                  dismissButton: .cancel()
                )
                return alert
            case .normal:
                let alert = Alert(title: Text("Checking..."),
                                  dismissButton: .cancel()
                )
                return alert
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
