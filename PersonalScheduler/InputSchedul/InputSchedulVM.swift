//
//  InputSchedulVM.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/11.
//

import Foundation

class InputSchedulVM: ViewModel {
    
    struct Input {
        let addButtonTrigger: Dynamic<Schedule?> = Dynamic(nil)
        let editButtonTrigger: Dynamic<Schedule?> = Dynamic(nil)
    }
    
    struct Output {
        let completion: Dynamic<Error?> = Dynamic(nil)
    }
    
    var input: Input
    var output: Output
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        inputBind()
    }
    
    // MARK: - InputBind
    private func inputBind() {
        input.addButtonTrigger.bind { [weak self] schedule in
            if let schedule {
                ScheduleManager.shared.addSchedule(schedule: schedule) { error in
                    if let error {
                        self?.output.completion.value = error
                    } else {
                        self?.output.completion.value = nil
                    }
                }
            }
        }
        
        input.editButtonTrigger.bind { [weak self] schedule in
            if let schedule {
                ScheduleManager.shared.editSchedule(schedule: schedule) { error in
                    if let error {
                        self?.output.completion.value = error
                    } else {
                        self?.output.completion.value = nil
                    }
                }
            }
        }
    }
}
