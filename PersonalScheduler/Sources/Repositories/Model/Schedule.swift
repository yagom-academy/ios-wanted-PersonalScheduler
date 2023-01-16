//
//  Schedule.swift
//  PersonalScheduler
//
//  Created by 이예은 on 2023/01/12.
//
import Foundation

struct Schedule: Codable {
    let email: String
    let id: String
    let title: String
    let body: String
    let startDate: String
    let endDate: String?
}
