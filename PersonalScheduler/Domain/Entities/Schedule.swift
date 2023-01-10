//
//  Schedule.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//
import Foundation

struct Schedule: Equatable {
    let id: UUID
    let title: String
    let body: String
    let startDate: String
    let endDate: String?
    
    func toCopy() -> ScheduleModel {
        return ScheduleModel(
            id: id,
            title: title,
            body: body,
            startDate: startDate,
            endDate: endDate
        )
    }
}

struct ScheduleModel {
    let id: UUID
    let title: String
    let body: String
    let startDate: String
    let endDate: String?
}
