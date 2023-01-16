//
//  Schedule.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//
import Foundation

struct Schedule: Equatable, Hashable {
    let id: UUID
    let title: String
    let body: String
    let startDate: String
    let endDate: String?
    
    var isOnSchedule: Bool {
        let dateManager = DateManager.shared
        let start = dateManager.convert(text: startDate)
        if endDate != "" {
            let end = dateManager.convert(text: endDate!)
            if dateManager.isBetween(startDate: start, endDate: end) {
                return true
            } else {
                return false
            }
        } else {
            if dateManager.isToday(date: start) {
                return true
            } else {
                return false
            }
        }
    }
    
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
