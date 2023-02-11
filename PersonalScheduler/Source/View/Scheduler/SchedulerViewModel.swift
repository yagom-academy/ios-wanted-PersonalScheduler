//  PersonalScheduler - SchedulerViewModel.swift
//  Created by zhilly on 2023/02/09

import Foundation

final class SchedulerViewModel {
    
    // MARK: - Properties

    let model: Observable<[Schedule]> = Observable(UserData.sample)
    
    // MARK: - Methods
}
