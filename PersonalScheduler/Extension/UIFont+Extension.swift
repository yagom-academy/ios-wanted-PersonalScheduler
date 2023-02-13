//
//  UIFont+Extension.swift
//  PersonalScheduler
//
//  Created by Mangdi on 2023/02/11.
//

import UIKit

extension UIFont {
    func withTraits(traits:UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor ?? UIFontDescriptor(), size: 0)
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
}
