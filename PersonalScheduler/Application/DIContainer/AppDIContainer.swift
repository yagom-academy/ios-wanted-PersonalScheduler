//
//  AppDIContainer.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

import Foundation

final class AppDIContainer {
    
    func makeLoginSceneDIContainer() -> LoginSceneDIContainer {
        let dependencies = LoginSceneDIContainer()
        return dependencies
    }
    
    func makeScheduleSceneDIContainer() -> ScheduleSceneDIContainer {
        let dependencies = ScheduleSceneDIContainer()
        return dependencies
    }
}
