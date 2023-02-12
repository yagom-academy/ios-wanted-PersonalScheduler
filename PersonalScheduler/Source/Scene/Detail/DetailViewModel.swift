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
    
    private enum Constant {
        static let defaultText = ""
    }
    
    private(set) var mode: Mode
    
    private var title: String = Constant.defaultText {
        didSet {
            titleHandler?(title)
        }
    }
    
    private var startDate: Date = Date() {
        didSet {
            startDateHandler?(startDate)
        }
    }
    
    private var endDate: Date = Date() {
        didSet {
            endDateHandler?(endDate)
        }
    }
    
    private var content: String = Constant.defaultText {
        didSet {
            contentHandler?(content)
        }
    }

    private var titleHandler: ((String) -> Void)?
    private var startDateHandler: ((Date) -> Void)?
    private var endDateHandler: ((Date) -> Void)?
    private var contentHandler: ((String) -> Void)?
    
    init(mode: Mode, data: Schedule? = nil) {
        self.mode = mode
        
    }
    
    func bindTitle(handler: @escaping (String) -> Void) {
        handler(title)
        titleHandler = handler
    }
    
    func bindStartDate(handler: @escaping (Date) -> Void) {
        handler(startDate)
        startDateHandler = handler
    }
    
    func bindEndDate(handler: @escaping (Date) -> Void) {
        handler(endDate)
        endDateHandler = handler
    }
    
    func bindContent(handler: @escaping (String) -> Void) {
        handler(content)
        contentHandler = handler
    }
}
