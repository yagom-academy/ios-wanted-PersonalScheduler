//
//  NavigationView.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import UIKit

class NavigationBar: UIView {
    let navigationTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "titleAccentColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "NanumGothicOTFBold", size: 18)
        return label
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        navigationTitleLabel.text = title
        backgroundColor = UIColor(named: "skyBlue")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        addSubview(navigationTitleLabel)
        
        NSLayoutConstraint.activate([
            navigationTitleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            navigationTitleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            navigationTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            navigationTitleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
