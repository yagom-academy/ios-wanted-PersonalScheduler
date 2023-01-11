//
//  UIColor+extension.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import UIKit

extension UIColor {
    class var psBackground: UIColor {
        return UIColor(named: "psBackground") ?? .clear
    }

    class var psSecondaryBackground: UIColor {
        return UIColor(named: "psSecondaryBackground") ?? .clear
    }
    
    class var psToday: UIColor {
        return UIColor(named: "psToday") ?? .clear
    }
}
