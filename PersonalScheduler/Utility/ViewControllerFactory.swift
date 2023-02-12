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
        let viewModel = LoginViewModel(service: service)
        let loginViewController = LoginViewController(viewModel: viewModel)
        
        return loginViewController
    }
    
    static private func makeScheduleViewController(userID: String) -> ScheduleViewController {
        let firestore = Firestore.firestore()
        let repository = DefaultRepository(dataBase: firestore)
        let service = ScheduleService(repository: repository)
        let scheduleViewModel = ScheduleViewModel(userID: userID, service: service)
        let scheduleViewController = ScheduleViewController(viewModel: scheduleViewModel)
        
        return scheduleViewController
    }
}
