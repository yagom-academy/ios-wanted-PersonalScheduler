//
//  String+toDate.swift
//  PersonalScheduler
//
//  Created by Judy on 2023/01/13.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.date(from: self)
    }
}
