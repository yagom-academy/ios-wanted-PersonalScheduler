//
//  Schedule.swift
//  PersonalScheduler
//
//  Created by Dragon on 23/02/07.
//

struct Schedule: Codable {
    let title: String
    let body: String
    let startDate: String
    let startTime: String
    let endDate: String
    let endTime: String
    let startTimeInterval1970: Double
    let endTimeInterval1970: Double
}
