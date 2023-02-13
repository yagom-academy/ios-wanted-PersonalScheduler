//
//  ListViewModel.swift
//  PersonalScheduler
//
//  Created by Kyo on 2023/02/09.
//

import Foundation

final class ListViewModel {
    enum Action {
        case present
        case add(data: Schedule)
        case delete(index: Int)
        case processUpdate(data: Schedule)
    }
    
    private var datas: [Schedule] = [] {
        didSet {
            dataHandler?(datas)
        }
    }
    
    private var dataHandler: (([Schedule]) -> Void)?
    private let fireBaseManager: FireStoreManager
    weak var presentDelegate: EventManageable?
    
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
    
    func dataAction(_ action: Action) {
        switch action {
        case .processUpdate(let data):
            fireBaseManager.update(data: data)
        case .delete(let index):
            fireBaseManager.delete(data: datas[index])
            datas.remove(at: index)
        case .present:
            presentDelegate?.presentDetailView(mode: .new, data: nil)
        case .add(let data):
            fireBaseManager.add(data: data)
            fetchData()
        }
    }
    
    private func fetchData() {
        fireBaseManager.load { datas in
            self.datas = datas
        }
    }
}
