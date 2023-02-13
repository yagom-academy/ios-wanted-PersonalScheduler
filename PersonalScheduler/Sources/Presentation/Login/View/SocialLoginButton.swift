//
//  SocialLoginButton.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import UIKit

final class SocialLoginButton: UIButton {
    enum loginCase: String {
        case kakao = "카카오"
        case facebook = "페이스북"
        case apple = "애플"
        
        var description: String {
            return "\(self.rawValue)로 계속하기"
        }
        
        var backgroundColor: UIColor? {
            switch self {
            case .kakao:
                return UIColor(named: "kakaoColor")
            case .facebook:
                return UIColor(named: "facebookColor")
            case .apple:
                return .black
            }
        }
        
        var labelColor: UIColor? {
            switch self {
            case .kakao:
                return .black
                
            case .facebook:
                return .white
                
            case .apple:
                return .white
            }
        }
        
        var logoFileName: String {
            switch self {
            case .kakao:
                return "kakaoLogo"
                
            case .facebook:
                return "facebookLogo"
                
            case .apple:
                return "AppleLogo"
            }
        }
    }
    
    private let logoView = UIImageView()
    private let nameLabel = UILabel()
    
    init(loginType: loginCase) {
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: 130, height: 50)))
        logoView.contentMode = .scaleAspectFit
        logoView.image = UIImage(named: loginType.logoFileName)
        nameLabel.text = loginType.description
        nameLabel.textAlignment = .center
        nameLabel.textColor = loginType.labelColor
        nameLabel.font = UIFont(name: "NanumGothicOTFBold", size: 18)
        backgroundColor = loginType.backgroundColor
        layer.cornerRadius = frame.height * 0.5
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutSubviews() {
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        [logoView, nameLabel].forEach(addSubview)
        
        let logoSize: CGFloat = 30
        let spacing: CGFloat = 10
        
        logoView.frame = CGRect(
            x: (spacing * 3),
            y: (frame.height - logoSize) / 2,
            width: logoSize,
            height: logoSize
        )
        
        nameLabel.frame = CGRect(
            x: (spacing * 4) + logoSize,
            y: (frame.height - logoSize) / 2,
            width: frame.width - (logoSize * 3),
            height: logoSize
        )
        
        
    }
}
