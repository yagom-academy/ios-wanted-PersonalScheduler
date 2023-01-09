//
//  Coordinator.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

protocol Coordinator: AnyObject {
    var childCoordinator: [Coordinator] { get set }
    func start()
}
