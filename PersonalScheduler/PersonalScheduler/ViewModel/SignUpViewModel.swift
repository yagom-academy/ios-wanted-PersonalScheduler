//
//  SignUpViewModel.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/09.
//

import Foundation
import FirebaseAuth

final class SignUpViewModel: ObservableObject {
    
    enum LoginResultAlert {
        case success, fail
    }
    
    @Published var errorMessage = ""
    @Published var isActiveAlert: Bool = false
    @Published var loginResultAlert: LoginResultAlert = .fail

    func registerUser(email: String, password: String) {
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                if let error = error {
                    print("Error : \(error.localizedDescription)")
                    self?.errorMessage = error.localizedDescription
                    self?.loginResultAlert = .fail
                    return
                }
                
                guard let user = result?.user else { return }
                self?.loginResultAlert = .success
                print(user.uid)
            }
        isActiveAlert.toggle()
        }
    
}
