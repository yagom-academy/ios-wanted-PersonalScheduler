//
//  String+Extension.swift
//  PersonalScheduler
//
//  Created by 우롱차 on 2023/01/13.
//

import Foundation

extension String {
    var toDate: Date? {
        return DateFormatter.defultDateFormatter.date(from: self)
    }
}
