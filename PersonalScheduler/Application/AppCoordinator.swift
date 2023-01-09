//
//  AppCoordinator.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    var childCoordinator: [Coordinator] = []
    private var navigationController: UINavigationController!
    private let appDIContainer: AppDIContainer
    
    var isLoggedIn: Bool = false
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        // 로그인을 한번 하면 캐싱된 결과값을 이용해 바로 로그인 수행
        if isLoggedIn {
            let scheduleSceneDIContainer = appDIContainer.makeScheduleSceneDIContainer()
            let flow = scheduleSceneDIContainer.makeMainFlowCoordinator(
                navigationController: navigationController
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
