//
//  SignUpView.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/09.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.presentationMode) var presentationMode

    @StateObject var signUpViewModel = SignUpViewModel()
    
    @State var newEmail: String = ""
    @State var newPassword: String = ""
    
    var body: some View {
        VStack {
            Text("Welcom!\nMy PersonalScheduler")
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
            
            GeometryReader { geometry in
                Button {
                    signUpViewModel.registerUser(email: newEmail, password: newPassword)
                } label: {
                    Text("Sign in")
                        .foregroundColor(.white)
                        .frame(width: geometry.size.width, height: 40)
                }
                .background(Color.purple)
            }
            .frame(height: 40)
            .cornerRadius(10)

        }
        .padding()
        .alert(isPresented: $signUpViewModel.isActiveAlert) {
            switch signUpViewModel.loginResultAlert {
            case .success:
                let alert = Alert(
                    title: Text("Success"),
                    message: Text("Welcom!!"),
                    dismissButton: .default(Text("확인"), action: {
                        presentationMode.wrappedValue.dismiss()
                    })
                )
                return alert
            case .fail:
                let alert = Alert(
                    title: Text("Error"),
                    message: Text(signUpViewModel.errorMessage),
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
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
