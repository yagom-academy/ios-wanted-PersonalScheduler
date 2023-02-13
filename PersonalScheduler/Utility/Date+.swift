//
//  Date+.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/12.
//

import Foundation

extension Date {
    enum DateType {
        case date
        case week
        case time
    }
    
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd"
        
        return dateFormatter.string(from: self)
    }
    
    func dropTime() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd"
        
        let date = dateFormatter.string(from: self)
        
        return dateFormatter.date(from: date) ?? self
    }
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
