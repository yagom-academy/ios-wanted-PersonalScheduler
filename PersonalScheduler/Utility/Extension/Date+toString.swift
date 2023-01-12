//
//  Date+toString.swift
//  PersonalScheduler
//
//  Created by Judy on 2023/01/12.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"

        return dateFormatter.string(from: self)
    }
}
