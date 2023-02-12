//
//  ScheduleCellViewModel.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/12.
//

import Foundation

protocol ScheduleCellViewModelDelegate: AnyObject {
    func scheduleCellViewModelDelegate(checkedResult: DateState)
}

enum DateState {
    case expired
    case today
    case notYet
}

final class ScheduleCellViewModel {
    weak var delegate: ScheduleCellViewModelDelegate?
    
    func checkDate(from startDate: Date, to endDate: Date) {
        let now = Date()
        
        if endDate.convertToString() == now.convertToString() || startDate.convertToString() == now.convertToString() {
            delegate?.scheduleCellViewModelDelegate(checkedResult: .today)
        } else if startDate <= now, now <= endDate {
            delegate?.scheduleCellViewModelDelegate(checkedResult: .today)
        } else if endDate < now {
            delegate?.scheduleCellViewModelDelegate(checkedResult: .expired)
        } else {
            delegate?.scheduleCellViewModelDelegate(checkedResult: .notYet)
        }
    }
}
