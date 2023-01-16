//
//  KakaoLoginViewController.swift
//  PersonalScheduler
//
//  Created by 이예은 on 2023/01/11.
//

import UIKit
import KakaoSDKUser
import FirebaseAuth

class KakaoLoginViewController: UIViewController {
    private let kakaoLoginManager = KakaoLoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        kakaoLogin()
    }
    
    func setup() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backButton.tintColor = .Red
        self.navigationItem.backBarButtonItem = backButton
    }
    
    func kakaoLogin() {
        kakaoLoginManager.kakaoLoginInWeb { oauthToken in
            _ = oauthToken
            
            self.kakaoLoginManager.getUserInfo { result in
                if let result = result {
                    let vc = MainViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}
