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
    @Published var isDismiss: Bool = false
    private var scheduleDetailRepository = ScheduleDetailRepository(dataBaseName: "Schedule")
    private var userRepository: ScheduleUserRepository
    private var cancellable = Set<AnyCancellable>()
    
    init(userRepository: ScheduleUserRepository) {
        self.userRepository = userRepository
    }
    
    func readData() {
        scheduleDetailRepository.readData(documentName: "Example")
            .replaceError(with: nil)
            .compactMap { $0 }
            .sink {
                self.detailSchedule = $0
            }
            .store(in: &cancellable)
    }
    
    func writeData() {
        scheduleDetailRepository.writeData(item: detailSchedule) { [weak self] result in
            guard let result = result else { return }
            
            self?.userRepository.writeUserSchedule(documentId: result) { result in
                switch result {
                case .success:
                    self?.isDismiss = true
                case .failure:
                    self?.isDismiss = false
                }
            }
        }
    }
    
    func updateStartDate(with date: Date) {
        detailSchedule.startTime = Timestamp(date: date)
    }
    
    func updateEndDate(with date: Date) {
        detailSchedule.endTime = Timestamp(date: date)
    }
}
