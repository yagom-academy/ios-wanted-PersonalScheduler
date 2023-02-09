//
//  UILabel+.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 2023/02/07.
//

import UIKit

extension UILabel {

    convenience init(text: String = "",
                     font: UIFont.TextStyle = .body,
                     fontBold: Bool = false,
                     textColor: UIColor? = .black,
                     numberOfLines: Int = 1,
                     textAlignment: NSTextAlignment = .center) {
        self.init(frame: .zero)
        self.text = text
        self.font = .preferredFont(forTextStyle: font)
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false

        if fontBold {
            self.font = .preferredFont(forTextStyle: font).bold()
        }
    }
}
