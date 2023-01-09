//
//  LoginV.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/09.
//

import UIKit

class LoginV: UIView, BaseView {
    
    lazy var kakaoLoginButton: KaKaoLoginButton = {
        let button = KaKaoLoginButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        self.addSubview(kakaoLoginButton)
    }
}
// MARK: - Constraints
extension LoginV {
    
    func constraints() {
        kakaoLoginButtonConst()
    }
    
    private func kakaoLoginButtonConst() {
        let layout = [
            kakaoLoginButton.heightAnchor.constraint(equalToConstant: 50),
            kakaoLoginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            kakaoLoginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            kakaoLoginButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50)
        ]
        
        NSLayoutConstraint.activate(layout)
    }
}
