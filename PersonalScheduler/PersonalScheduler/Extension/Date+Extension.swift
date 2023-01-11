//
//  Date+Extension.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/10.
//

import Foundation

extension Date {
    var dateFormatter: DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd. HH시 mm분"
        
        return dateFormatter
    }
    
    func translateToString() -> String {
        
        return dateFormatter.string(from: self)
    }

}
