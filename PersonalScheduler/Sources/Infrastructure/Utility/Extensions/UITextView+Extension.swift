//
//  UITextView.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.
        
import Combine
import UIKit

extension UITextView {
    var textPublisher: AnyPublisher<String?, Never> {
        return NotificationCenter.default.publisher(for: UITextView.textDidChangeNotification)
            .map { ($0.object as? UITextView)?.text }
            .eraseToAnyPublisher()
    }
}
