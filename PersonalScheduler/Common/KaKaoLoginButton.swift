//
//  KaKaoLoginButton.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/09.
//

import UIKit

class KaKaoLoginButton: UIButton {
    private let kakaoLoginImage = UIImage(named: "kakao_login_large_wide")
    
    private func setting() {
        self.setBackgroundImage(kakaoLoginImage, for: .normal)
        self.setTitle(nil, for: .normal)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
