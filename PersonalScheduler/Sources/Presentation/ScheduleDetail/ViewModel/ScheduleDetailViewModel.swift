//
//  ScheduleDetailViewModel.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

final class ScheduleDetailViewModel {
    @Published var detailSchedule: Schedule = Schedule.baseSchedule
    private var database: CollectionReference
    private var repository = ScheduleDetailRepository(dataBaseName: "Users")
    private var cancellable = Set<AnyCancellable>()
    
    init(with collectionName: String) {
        database = Firestore.firestore().collection(collectionName)
        
        readData()
    }
    
    func readData() {
        repository.readData(documentName: "Schedule")
            .replaceError(with: nil)
            .compactMap { $0 }
            .sink {
                self.detailSchedule = $0
            }
            .store(in: &cancellable)
    }
    
    func writeData() {
        repository.writeData(documentName: "Schedule", item: detailSchedule) { result in
            switch result {
            case .success:
                print("success")
            case .failure:
                print("Error in write")
            }
        }
    }
}
