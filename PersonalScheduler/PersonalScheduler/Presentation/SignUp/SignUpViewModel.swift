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
        case success, fail, normal
    }
    
    @Published var isActiveAlert: Bool = false
    @Published var errorMessage: String = ""
    @Published var loginResultAlert: LoginResultAlert = .fail
    
    func registerUser(email: String, password: String) {
        loginResultAlert = .normal
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                self?.errorMessage = error.localizedDescription
                self?.loginResultAlert = .fail
                return
            }
            
            guard let user = result?.user else { return }
            self?.loginResultAlert = .success
        }
        isActiveAlert = true
    }
    
}
