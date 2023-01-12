//
//  FacebookLoginService.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/11.
//

import FacebookLogin
import FacebookCore

final class FacebookLoginService {
    private let loginManager = LoginManager()
    
    var isLoggedin: Bool {
        if let token = AccessToken.current, !token.isExpired {
            return true
        } else {
            return false
        }
    }
    
    func login(in viewController: UIViewController, _ completion: @escaping () -> Void) {
        loginManager.logIn(permissions: ["public_profile", "email"], from: viewController) { result, error in
            if let error = error {
                print(error)
            } else if let result = result, result.isCancelled {
                print("login is cancelled")
            } else {
                print("success login")
                completion()
            }
        }
    }
    
    func fetchAccessToken() -> AccessToken? {
        if isLoggedin {
            return AccessToken.current
        } else {
            return nil
        }
    }
    
    func fetchProfile(_ completion: @escaping (Profile?) -> Void) {
        Profile.loadCurrentProfile { profile, error in
            if let error = error {
                print(error)
                completion(nil)
            } else {
                completion(profile)
            }
        }
    }
}
