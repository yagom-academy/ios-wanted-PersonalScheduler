//
//  ScheduleDetailViewModel.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

final class ScheduleDetailViewModel {
    @Published var detailSchedule: Schedule? = nil
    private var database: CollectionReference
    private var repository = ScheduleDetailRepository(dataBaseName: "Users")
    private var cancellable = Set<AnyCancellable>()
    
    init(with collectionName: String) {
        database = Firestore.firestore().collection(collectionName)
        
        readData()
    }
    
    func readData() {
        repository.readData(documentName: "Example")
            .replaceError(with: nil)
            .sink { self.detailSchedule = $0 }
            .store(in: &cancellable)
    }
}
