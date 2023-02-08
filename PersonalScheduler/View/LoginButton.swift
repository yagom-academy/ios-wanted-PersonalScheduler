//
//  UIButton+.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 2023/02/08.
//

import UIKit

final class LoginButton: UIButton {

    private let loginLabel = UILabel(font: .title3, fontBold: true, textAlignment: .center)
    private let logoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let logoSize: CGFloat = 28
        let spacing: CGFloat = 10
        let loginLabelX: CGFloat = logoSize + (2 * spacing)

        layer.cornerRadius = 12
        logoImageView.frame = CGRect(x: spacing, y: (frame.height - logoSize)/2,
                                     width: logoSize, height: logoSize)
        loginLabel.frame = CGRect(x: loginLabelX, y: 0,
                                  width: (frame.width - loginLabelX), height: frame.size.height)
    }

    func configure(with viewModel: loginButtonViewModel) {
        loginLabel.text = viewModel.title
        loginLabel.textColor = viewModel.textColor
        logoImageView.image = viewModel.logo
        backgroundColor = viewModel.backgroundColor
    }

    private func configureHierarchy() {
        self.addSubview(logoImageView)
        self.addSubview(loginLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
