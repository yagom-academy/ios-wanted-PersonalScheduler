//
//  ListViewModel.swift
//  PersonalScheduler
//
//  Created by parkhyo on 2023/02/09.
//

import Foundation

final class ListViewModel {
    private let fireBaseManager: FireStoreManager
    
    init(_ fireBaseManager: FireStoreManager) {
        self.fireBaseManager = fireBaseManager
    }
    
    func fetchName() -> String {
        return fireBaseManager.fetchUserName()
    }
}
