//
//  Date+.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 2023/02/09.
//

import Foundation

extension Date {

    func convertSlashFormatString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm월 dd일"

        return dateFormatter.string(from: self)
    }
}
