//
//  ScheduleMakingViewModel.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/12.
//

import Foundation

final class ScheduleMakingViewModel {
    private let saveScheduleUseCase: SaveScheduleUseCase

    init(saveScheduleUseCase: SaveScheduleUseCase) {
        self.saveScheduleUseCase = saveScheduleUseCase
    }
}
