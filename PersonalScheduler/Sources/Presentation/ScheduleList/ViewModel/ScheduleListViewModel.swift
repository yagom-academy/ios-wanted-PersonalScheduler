//
//  ScheduleViewModel.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine

final class ScheduleListViewModel {
    @Published var isLogged: Bool
    
    init(isLogged: Bool) {
        self.isLogged = isLogged
    }
    
    func logout() {
        FirebaseAuthService().logout { [weak self] result in
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
