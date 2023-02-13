//
//  CellViewModel.swift
//  PersonalScheduler
//
//  Created by Kyo on 2023/02/11.
//

import Foundation

final class CellViewModel {
    private var schedule: Schedule {
        didSet {
            updateHandler?(schedule)
        }
    }
    
    private var updateHandler: ((Schedule) -> Void)?
    
    init(data: Schedule) {
        schedule = data
    }
    
    func bindData(completion: @escaping (Schedule) -> Void) {
        completion(schedule)
        updateHandler = completion
    }
    
    func changeState() -> Schedule {
        if schedule.state == .ready {
            schedule.state = .complete
        } else {
            schedule.state = .ready
        }
        return schedule
    }
}
