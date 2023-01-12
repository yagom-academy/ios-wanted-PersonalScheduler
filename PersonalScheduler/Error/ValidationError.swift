//
//  ValidationError.swift
//  PersonalScheduler
//
//  Created by 우롱차 on 2023/01/13.
//

import Foundation

enum ValidationError: Error {
    case titleIsEmpty
    case contentsIsTooLong
    case dateIsEmpty
}
