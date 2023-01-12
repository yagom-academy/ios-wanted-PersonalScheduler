//
//  FacebookLoginUseCase.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/11.
//

import FacebookLogin
import UIKit

struct FacebookLoginUseCase {
    private let facebookLoginService = FacebookLoginService()
    
    func login(in vc: UIViewController, _ completion: @escaping () -> Void) {
        facebookLoginService.login(in: vc) {
            completion()
        }
    }
    
    func fetchEmail(_ completion: @escaping (String?) -> Void) {
        facebookLoginService.fetchProfile { profile in
            guard let profile = profile else {
                completion(nil)
                return
            }
            completion(profile.email)
        }
    }
}
