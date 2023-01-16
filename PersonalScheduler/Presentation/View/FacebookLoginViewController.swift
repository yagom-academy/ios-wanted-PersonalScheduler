//
//  FacebookLoginViewController.swift
//  PersonalScheduler
//
//  Created by 이예은 on 2023/01/10.
//

import UIKit
import FacebookLogin

class FacebookLoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        view.addSubview(loginButton)
        
        if let token = AccessToken.current,
           !token.isExpired {
            
            let vc = MainViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
