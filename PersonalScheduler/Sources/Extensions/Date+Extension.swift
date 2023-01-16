//
//  Date+Extension.swift
//  PersonalScheduler
//
//  Created by 이예은 on 2023/01/13.
//

import Foundation

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd."
        
        return formatter.string(from: self)
    }
}
