//
//  Date+toString.swift
//  PersonalScheduler
//
//  Created by Judy on 2023/01/12.
//

import Foundation

extension Date {
    func convertToString(isOnlyTime: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        
        if isOnlyTime {
            dateFormatter.dateFormat = "HH:mm"
        } else {
            dateFormatter.dateFormat = "yyyy.MM.dd"
        }
        
        return dateFormatter.string(from: self)
    }
}
