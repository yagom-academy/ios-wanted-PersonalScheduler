//
//  UINavigationController+extension.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import UIKit

extension UINavigationController {
    
    func addCustomBottomLine(color: UIColor, height: Double) {
        navigationBar.setValue(true, forKey: "hidesShadow")
        let lineView = UIView()
        lineView.backgroundColor = color
        navigationBar.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.widthAnchor.constraint(equalTo: navigationBar.widthAnchor),
            lineView.heightAnchor.constraint(equalToConstant: CGFloat(height)),
            lineView.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),
            lineView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor)
        ])
    }
    
}
