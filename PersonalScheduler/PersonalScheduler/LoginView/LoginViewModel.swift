//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Created by minsson on 2023/01/12.
//

import Foundation

final class LoginViewModel: ObservableObject {
    
    @Published private(set) var isLoginFinished = false
    @Published private(set) var firebaseID = ""
    
    let kakaoOAuthService: OAuthProvider = KakaoOAuthService()
    
    @MainActor
    func loginButtonTapped(serviceName: OAuthProvider) {
        Task {
            await serviceName.retrieveUserID()
            firebaseID = serviceName.toFirebaseID()
            isLoginFinished = true
            
            if await FirebaseService.shared.isNewUser(firebaseID: firebaseID) {
                FirebaseService.shared.addUserToDatabase(firebaseID: firebaseID)
            }
        }
    }
    
    func logoutButtonTapped(serviceName: OAuthProvider) {
        serviceName.executeLogout()
    }
    
}
