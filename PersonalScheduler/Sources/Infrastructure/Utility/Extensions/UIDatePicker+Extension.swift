//
//  UIDatePicker+Extension.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import UIKit

extension UIDatePicker {
    var dateSelectedPublisher: AnyPublisher<Date?, Never> {
        return controlPublisher(for: .valueChanged)
            .compactMap { ($0 as? UIDatePicker)?.date }
            .filter { [weak self] in
                if let maximumDate = self?.maximumDate, let date = $0 {
                    return date <= maximumDate
                } else {
                    return true
                }
            }
            .filter { [weak self] in
                if let minimumDate = self?.minimumDate, let date = $0 {
                    return date >= minimumDate
                } else {
                    return true
                }
            }
            .eraseToAnyPublisher()
    }
}
