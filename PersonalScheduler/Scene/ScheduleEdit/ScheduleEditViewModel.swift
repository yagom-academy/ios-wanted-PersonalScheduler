//
//  ScheduleEditViewModel.swift
//  PersonalScheduler
//
//  Created by 이호영 on 2023/01/12.
//

import Foundation

protocol ScheduleEditViewModelInput {
    func addSchedule(title: String, time: Date, content: String)
}

protocol ScheduleEditViewModelOutput {
    var schedule: Observable<ScheduleInfo?> { get }
    var error: Observable<String?> { get }
    var dismiss: Observable<Bool?> { get }
}

protocol ScheduleEditViewModelType: ScheduleEditViewModelInput, ScheduleEditViewModelOutput { }

final class ScheduleEditViewModel: ScheduleEditViewModelType {

    private let scheduleUseCase = ScheduleUseCase()
    
    private var addScheduleTask: Task<Void, Error>?
    
    /// Output
    
    var schedule: Observable<ScheduleInfo?> = Observable(nil)
    var error: Observable<String?> = Observable(nil)
    var dismiss: Observable<Bool?> = Observable(nil)
    
    /// Input
    
    init(_ schedule: ScheduleInfo?) {
        self.schedule.value = schedule
    }
    
    func addSchedule(title: String, time: Date, content: String) {
        let titleText = title.trimmingCharacters(in: .whitespaces)
        let contentText = content.trimmingCharacters(in: .whitespaces)
        
        if titleText == "" {
            self.error.value = "일정 제목을 입력해주세요"
            return
        }
        
        if contentText == "" {
            self.error.value = "일정 내용을 입력해주세요"
            return
        }
        
        let schedule = ScheduleInfo(id: UUID().uuidString, title: titleText, time: time.timeIntervalSince1970, content: contentText)
        
        addScheduleTask = Task {
            do {
                try await scheduleUseCase.addSchedule(schedule)
                dismiss.value = true
            }
            catch {
                self.error.value = error.localizedDescription
            }
        }
        addScheduleTask?.cancel()
    }
}
