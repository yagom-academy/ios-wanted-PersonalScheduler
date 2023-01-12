//
//  ScheduleAddViewModel.swift
//  PersonalScheduler
//
//  Created by unchain on 2023/01/12.
//

import Foundation
import Combine

protocol ScheduleAddViewModelInputInterface {
    func tappedSaveButton()
}

protocol ScheduleAddViewModelOutputInterface {
    var scheduleSavePublisher: PassthroughSubject<Void, Never> { get }
    var dismissPublisher: PassthroughSubject<Void, Never> { get }
}

protocol ScheduleAddViewModelInterface {
    var input: ScheduleAddViewModelInputInterface { get }
    var output: ScheduleAddViewModelOutputInterface { get }
}

final class ScheduleAddViewModel: ScheduleAddViewModelInterface, ScheduleAddViewModelOutputInterface {
    var input: ScheduleAddViewModelInputInterface { self }
    var output: ScheduleAddViewModelOutputInterface { self }
    var scheduleSavePublisher = PassthroughSubject<Void, Never>()
    var dismissPublisher = PassthroughSubject<Void, Never>()
}

extension ScheduleAddViewModel: ScheduleAddViewModelInputInterface {
    func tappedSaveButton() {
        scheduleSavePublisher.send()
        dismissPublisher.send()
    }
}
