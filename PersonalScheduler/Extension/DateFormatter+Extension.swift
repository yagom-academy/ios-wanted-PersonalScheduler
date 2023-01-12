//
//  DateFormatter+Extension.swift
//  PersonalScheduler
//
//  Created by 우롱차 on 2023/01/13.
//

import Foundation

extension DateFormatter {
    static var defultDateFormatter: DateFormatter = {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd HH:mm"
        return dateformatter
    }()
}
