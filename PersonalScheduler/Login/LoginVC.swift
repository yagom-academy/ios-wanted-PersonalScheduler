//
//  LoginVC.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/09.
//

import UIKit
import KakaoSDKAuth

class LoginVC: BaseVC {
    // MARK: - View
    private let loginView = LoginV()
    
    override func loadView() {
        self.view = loginView
    }
    // MARK: - ViewModel
    
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
// MARK: - Constraint
