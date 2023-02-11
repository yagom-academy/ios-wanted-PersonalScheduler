//
//  ListViewModel.swift
//  PersonalScheduler
//
//  Created by Kyo on 2023/02/09.
//

import Foundation

final class ListViewModel {
    private var datas: [Schedule] = [] {
        didSet {
            dataHandler?(datas)
        }
    }
    
    private var dataHandler: (([Schedule]) -> Void)?
    
    private let fireBaseManager: FireStoreManager
    
    init(_ fireBaseManager: FireStoreManager) {
        self.fireBaseManager = fireBaseManager
        fetchData()
    }
    
    func bindData(completion: @escaping ([Schedule]) -> Void) {
        completion(datas)
        dataHandler = completion
    }
    
    func fetchName() -> String {
        return fireBaseManager.fetchUserName()
    }
    
    func updateDataProcess(_ data: Schedule) {
        fireBaseManager.update(data: data)
    }
    
    private func fetchData() {
        fireBaseManager.load { datas in
            self.datas = datas
            print(datas)
        }
    }
    
    
}
