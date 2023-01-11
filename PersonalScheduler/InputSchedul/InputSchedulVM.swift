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
    }
    
    struct Output {
        
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
        input.addButtonTrigger.bind { [weak self] optionalSchedule in
            if let schedule = optionalSchedule {
                ScheduleManager.shared.addShedule(schedule: schedule) { error in
                    if let error = error {
                        print(error)
                    } else {
                        print("성공")
                    }
                }
            }
        }
    }
}
