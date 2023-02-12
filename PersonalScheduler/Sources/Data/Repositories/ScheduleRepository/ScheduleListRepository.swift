//
//  ScheduleListRepository.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

final class ScheduleListRepository {
    @Published var schedules: [Schedule] = []
    @Published private var ids: [String] = []
    
    private let scheduleDatabase = Firestore.firestore().collection("Schedule")
    private let userDatabase = Firestore.firestore().collection("Users")
    private let authService: FirebaseAuthService
    
    private var cancellable = Set<AnyCancellable>()
    
    init(authService: FirebaseAuthService) {
        self.authService = authService
        
        readScheduleIds()
        
        $ids.sink { values in
            self.readListData(ids: values)
        }
        .store(in: &cancellable)
    }
    
    func readScheduleIds() {
        userDatabase.document(authService.userId)
            .addSnapshotListener { snapshot, error in
                guard let values = snapshot?.data(),
                      let ids = values["schedules"] as? [String] else { return }
                self.ids = ids
            }
    }
    
    func readListData(ids: [String]) {
        ids.forEach {
            scheduleDatabase.document($0)
                .toAnyPublisher()
                .replaceError(with: nil)
                .compactMap { $0 }
                .sink { schedule in
                    self.schedules.append(schedule)
                }
                .store(in: &cancellable)
        }
    }
}
