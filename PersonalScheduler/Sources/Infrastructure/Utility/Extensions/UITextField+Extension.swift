//
//  UITextField+Extension.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String?, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification)
            .map { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
    }
}
