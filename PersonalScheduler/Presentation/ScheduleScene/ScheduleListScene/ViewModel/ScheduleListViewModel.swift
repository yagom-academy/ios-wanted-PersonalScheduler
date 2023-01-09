//
//  ScheduleListViewModel.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

struct ScheduleListViewModelActions {
    let showScheduleDetails: (Schedule) -> Void
}
protocol ScheduleListViewModelInput {
    func showScheduleDetail(_ schedule: Schedule)
    func deleteSchedule(_ schedule: Schedule)
}
protocol ScheduleListViewModelOutput {}
protocol ScheduleListViewModel: ScheduleListViewModelInput, ScheduleListViewModelOutput {}

final class DefaultScheduleListViewModel: ScheduleListViewModel {
    
    private let actions: ScheduleListViewModelActions?
    
    init(actions: ScheduleListViewModelActions? = nil) {
        self.actions = actions
    }
    
    func showScheduleDetail(_ schedule: Schedule) {
        actions?.showScheduleDetails(schedule)
        // 셀이 didSelectedRowAt으로 전달되었을 때, 해당 모델을 파라미터로
    }
    
    func deleteSchedule(_ schedule: Schedule) {
        // 셀 삭제 action
    }
}
