//
//  ScheduleDetailViewModel.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine

final class ScheduleDetailViewModel {
    private let service = FireStoreService<[Schedule]>(referenceName: "Users")
    private var cancellable = Set<AnyCancellable>()
    // TODO: - Schedule 저장, 삭제, 업데이트
    
    func readData() {
        service.readData(documentReference: "Schedule", collectionReference: "Example")
            .replaceError(with: nil)
            .sink { values in
                print(values)
            }
            .store(in: &cancellable)
    }
}
