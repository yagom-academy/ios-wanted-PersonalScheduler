//
//  LoginButton.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/10.
//

import UIKit

final class LoginButton: UIButton {
    private let buttonMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Futura-Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init(buttonMessage: String?, textColor: UIColor?, logo: UIImage?, backgroundColor: UIColor?) {
        super.init(frame: .zero)
        
        buttonMessageLabel.text = buttonMessage
        buttonMessageLabel.textColor = textColor
        logoView.image = logo
        self.backgroundColor = backgroundColor
        configureView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(logoView)
        addSubview(buttonMessageLabel)
        self.layer.cornerRadius = 30
    }
    
    private func configureLayout() {
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            logoView.heightAnchor.constraint(equalTo: logoView.widthAnchor),
            logoView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.4),
            logoView.centerXAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 30),
            logoView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            
            buttonMessageLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            buttonMessageLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: 12)
        ])
    }
}
