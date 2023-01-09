//
//  ScheduleDetailViewModel.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

protocol ScheduleDetailViewModelInput {
    var currentSchedule: Schedule { get }
}

protocol ScheduleDetailViewModelOutput {}
protocol ScheduleDetailViewModel: ScheduleDetailViewModelInput, ScheduleDetailViewModelOutput {}

final class DefaultScheduleDetailViewModel: ScheduleDetailViewModel {
    private(set) var currentSchedule: Schedule
    
    init(currentSchedule: Schedule) {
        self.currentSchedule = currentSchedule
    }
}
