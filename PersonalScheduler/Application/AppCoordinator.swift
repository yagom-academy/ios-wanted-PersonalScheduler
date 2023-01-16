//
//  AppCoordinator.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    private let appDIContainer: AppDIContainer
    private var navigationController: UINavigationController!
    private var previousLoginInfo: String?
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
        let loginCacheManager = LoginCacheManager()
        previousLoginInfo = loginCacheManager.fetchPreviousInfo()
    }
    
    func start() {
        if let loginInfo = previousLoginInfo {
            let scheduleSceneDIContainer = appDIContainer.makeScheduleSceneDIContainer()
            let flow = scheduleSceneDIContainer.makeMainFlowCoordinator(
                navigationController: navigationController,
                fireStoreCollectionId: loginInfo
            )
            flow.start()
        } else {
            let loginSceneDIContainer = appDIContainer.makeLoginSceneDIContainer()
            let flow = loginSceneDIContainer.makeLoginFlowCoordinator(
                navigationController: navigationController
            )
            flow.start()
        }
    }
}
