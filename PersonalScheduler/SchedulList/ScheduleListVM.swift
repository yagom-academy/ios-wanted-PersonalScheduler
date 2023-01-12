//
//  ScheduleListVM.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/10.
//

import Foundation

class ScheduleListVM: ViewModel {
    
    struct Input {
        let viewDidLoadTrigger: Dynamic<Void> = Dynamic(())
        let deleteScheduleTrigger: Dynamic<String?> = Dynamic(nil)
    }
    
    struct Output {
        let scheduleList: Dynamic<[Schedule]?> = Dynamic(nil)
        var currentDate: Date = Date()
        let completion: Dynamic<Error?> = Dynamic(nil)
    }
    
    var input: Input
    var output: Output
    
    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
        inputBind()
    }
    
    // MARK: - inputBind
    private func inputBind() {
        input.viewDidLoadTrigger.bind { [weak self] _ in
            self?.fetchSchedulList()
        }
        
        input.deleteScheduleTrigger.bind { [weak self] scheduleUid in
            self?.deleteSchedul(uid: scheduleUid!)
        }
    }
    
    func fetchSchedulList() {
        ScheduleManager.shared.fetchScheduleListData(completion: { [weak self] scheduleList, error in
            if let error {
                self?.output.completion.value = error
            } else {
                self?.output.scheduleList.value = scheduleList
            }
        })
    }
    
    private func deleteSchedul(uid: String) {
        ScheduleManager.shared.deleteSchedule(scheduleUid: uid) { [weak self] deleteError in
            if let deleteError {
                self?.output.completion.value = deleteError
            } else {
                self?.fetchSchedulList()
            }
        }
    }
}
