//
//  LoginButton.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import UIKit

final class LoginButton: UIButton {
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 56, height: 56)
    }

    convenience init(image: UIImage?) {
        self.init(frame: .zero)
        let image = image?
            .withRenderingMode(.alwaysOriginal)
        setImage(image, for: .normal)
    }
}
