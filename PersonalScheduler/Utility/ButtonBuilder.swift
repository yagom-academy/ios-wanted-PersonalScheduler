//
//  ButtonBuilder.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/09.
//

import UIKit

final class ButtonBuilder {
    private var buttonMessage: String?
    private var textColor: UIColor?
    private var logoImage: UIImage?
    private var backgroundColor: UIColor?
    
    func withProviderName(_ name: String) -> ButtonBuilder {
        buttonMessage = "Login with \(name)"
        return self
    }
    
    func withTextColor(_ color: UIColor) -> ButtonBuilder {
        textColor = color
        return self
    }
    
    func withLogoImage(_ image: UIImage?) -> ButtonBuilder {
        logoImage = image
        return self
    }
    
    func withBackgroundColor(_ color: UIColor) -> ButtonBuilder {
        backgroundColor = color
        return self
    }
    
    func build() -> LoginButton {
        let loginButton = LoginButton(
            buttonMessage: buttonMessage,
            textColor: textColor,
            logo: logoImage,
            backgroundColor: backgroundColor
        )
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        return loginButton
    }
}
