//
//  ViewControllerFactory.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/11.
//

import UIKit

import FirebaseFirestore

enum ControllerType {
    case login
    case schedule(userID: String)
}

enum ViewControllerFactory {
    static private let loginService = LoginService()
    
    static func makeViewController(type: ControllerType) -> UIViewController {
        switch type {
        case .login:
            return makeLoginViewController()
        case .schedule(let userID):
            return makeScheduleViewController(userID: userID)
        }
    }
    
    static private func makeLoginViewController() -> LoginViewController {
        let service = LoginService()
        let viewModel = LoginViewModel(service: loginService)
        let loginViewController = LoginViewController(viewModel: viewModel)
        
        return loginViewController
    }
    
    static private func makeScheduleViewController(userID: String) -> ScheduleViewController {
        let firestore = Firestore.firestore()
        let repository = DefaultRepository(dataBase: firestore)
        let scheduleService = ScheduleService(repository: repository)
        let scheduleViewModel = ScheduleViewModel(
            userID: userID,
            scheduleservice: scheduleService,
            loginService: loginService
        )
        let scheduleViewController = ScheduleViewController(viewModel: scheduleViewModel)
        
        return scheduleViewController
    }
}
