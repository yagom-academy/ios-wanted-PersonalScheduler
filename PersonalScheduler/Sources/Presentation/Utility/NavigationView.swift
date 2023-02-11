//
//  NavigationView.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import UIKit

class NavigationBar: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(named: "skyBlue")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
