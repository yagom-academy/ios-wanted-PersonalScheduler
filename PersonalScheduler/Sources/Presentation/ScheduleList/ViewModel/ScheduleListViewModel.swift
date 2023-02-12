//
//  ScheduleViewModel.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine

final class ScheduleListViewModel {
    @Published var isLogged: Bool = true
    @Published var schedules: [Schedule] = []
    private let listRepository: ScheduleListRepository
    let firebaseAuthService = FirebaseAuthService()
    
    private var cancellable = Set<AnyCancellable>()
    
    init(listRepository: ScheduleListRepository) {
        self.listRepository = listRepository
        firebaseAuthService.setExistUserId()
        
        readList()
    }
    
    func readList() {
        listRepository.$schedules
            .sink {
                self.schedules = $0
            }
            .store(in: &cancellable)
    }
    
    func logout() {
        firebaseAuthService.logout { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.isLogged = false
                
            case .failure:
                self.isLogged = true
            }
        }
    }
}
