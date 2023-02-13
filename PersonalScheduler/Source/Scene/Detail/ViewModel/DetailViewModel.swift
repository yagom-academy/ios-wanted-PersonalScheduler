//
//  DetailViewModel.swift
//  PersonalScheduler
//
//  Created by Kyo on 2023/02/13.
//

import Foundation

final class DetailViewModel {
    private enum Constant {
        static let defaultText = ""
    }
    
    private(set) var mode: Mode
    
    private let id: UUID
    
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
        guard let data = data else {
            id = UUID()
            return
        }
        id = data.id
        title = data.title
        content = data.content
        startDate = data.startDate
        endDate = data.endDate
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
    
    func makeData(title: String?, content: String?, start: Date?, end: Date?) -> Schedule {
        return Schedule(
            id: id,
            startDate: start ?? Date(),
            endDate: end ?? Date(),
            title: title ?? "",
            content: content ?? "",
            state: .ready
        )
    }
}
