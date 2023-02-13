//
//  UIFont+.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 2023/02/07.
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
