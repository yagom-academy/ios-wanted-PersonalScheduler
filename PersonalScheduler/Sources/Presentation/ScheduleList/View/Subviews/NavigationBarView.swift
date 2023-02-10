//
//  NavigationBarView.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import UIKit

final class NavigationBar: UIView {
    private let navigationTitleLabel: UILabel = {
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
        translatesAutoresizingMaskIntoConstraints = false
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        addSubview(navigationTitleLabel)
        
        NSLayoutConstraint.activate([
            navigationTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            navigationTitleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            navigationTitleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            navigationTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
        ])
    }
}
