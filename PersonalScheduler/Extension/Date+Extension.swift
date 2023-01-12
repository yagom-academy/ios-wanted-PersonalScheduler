//
//  Date+Extension.swift
//  PersonalScheduler
//
//  Created by 우롱차 on 2023/01/13.
//

import Foundation

extension Date {
    var toString: String {
        return DateFormatter.defultDateFormatter.string(from: self)
    }
}
