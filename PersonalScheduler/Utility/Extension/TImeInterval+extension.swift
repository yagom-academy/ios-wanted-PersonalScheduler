//
//  TImeInterval.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/13.
//

import Foundation

extension TimeInterval {
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: self))
        return dateString
    }
}
