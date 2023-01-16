//
//  UIColor+Extension.swift
//  PersonalScheduler
//
//  Created by 이예은 on 2023/01/13.
//

import UIKit

extension UIColor {
    
    @nonobjc class var Red: UIColor {
        return UIColor(red: 0.565, green: 0.169, blue: 0.129, alpha: 1)
    }
    
    @nonobjc class var Red_60: UIColor {
        return UIColor(red: 0.565, green: 0.169, blue: 0.129, alpha: 0.6)
    }
    
    @nonobjc class var White: UIColor {
        return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @nonobjc class var White_60: UIColor {
        return UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
    }
    
    @nonobjc class var Gray1: UIColor {
        return UIColor(red: 0.642, green: 0.642, blue: 0.642, alpha: 1)
    }
    
    @nonobjc class var Gray2: UIColor {
        return UIColor(red: 0.558, green: 0.558, blue: 0.558, alpha: 1)
    }
    
    @nonobjc class var Gray2_60: UIColor {
        return UIColor(red: 0.558, green: 0.558, blue: 0.558, alpha: 0.6)
    }
    
    @nonobjc class var Beige: UIColor {
        return UIColor(red: 0.929, green: 0.922, blue: 0.875, alpha: 1)
    }
    
    @nonobjc class var LightBeige: UIColor {
        return UIColor(red: 0.996, green: 0.993, blue: 0.979, alpha: 1)
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    static var boBackground: UIColor {
        return UIColor(r: 26, g: 26, b: 26)
    }
}
