//
//  String+Extension.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/11.
//

import Foundation

extension String {
    var dateFormatter: DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd. HH시 mm분"

        return dateFormatter
    }
    
    func translateToDate() -> Date {
        
        return dateFormatter.date(from: self) ?? Date()
    }
}
