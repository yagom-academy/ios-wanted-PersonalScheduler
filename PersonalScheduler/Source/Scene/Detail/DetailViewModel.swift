//
//  DetailViewModel.swift
//  PersonalScheduler
//
//  Created by Kyo on 2023/02/13.
//

import Foundation

final class DetailViewModel {
    enum Mode: String {
        case new = "New 📌"
        case edit = "Edit 🖍"
    }
    
    private(set) var mode: Mode
    
    private var data: Schedule? {
        didSet {
            
        }
    }
    
    init(mode: Mode, data: Schedule? = nil) {
        self.mode = mode
        self.data = data
    }
}
