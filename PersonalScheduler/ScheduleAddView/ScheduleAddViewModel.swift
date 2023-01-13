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
    func tappedEditButton()
    func onViewDidLoad()
}

protocol ScheduleAddViewModelOutputInterface {
    var scheduleSavePublisher: PassthroughSubject<Void, Never> { get }
    var scheduleEditPublisher: PassthroughSubject<ScheduleModel, Never> { get }
    var dismissPublisher: PassthroughSubject<Void, Never> { get }
    var scheduleModelPublisher: PassthroughSubject<ScheduleModel, Never> { get }
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
    var scheduleModelPublisher = PassthroughSubject<ScheduleModel, Never>()
    var scheduleEditPublisher = PassthroughSubject<ScheduleModel, Never>()
    var readSchedule: ScheduleModel = ScheduleModel(documentId: "",
                                                    title: "",
                                                    startDate: "",
                                                    mainText: "")

    init(readSchedule: ScheduleModel) {
        self.readSchedule = readSchedule
    }
}

extension ScheduleAddViewModel: ScheduleAddViewModelInputInterface {
    func tappedEditButton() {
        scheduleEditPublisher.send(readSchedule)
        dismissPublisher.send()
    }

    func onViewDidLoad() {
        scheduleModelPublisher.send(readSchedule)
    }

    func tappedSaveButton() {
        scheduleSavePublisher.send()
        dismissPublisher.send()
    }
}
