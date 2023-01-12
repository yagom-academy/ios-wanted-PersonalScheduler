//
//  ListViewModel.swift
//  PersonalScheduler
//
//  Created by unchain on 2023/01/11.
//

import Foundation
import Combine

protocol ListViewModelInputInterface {
    func tappedAddButton()
}

protocol ListViewModelOutputInterface {
    var scheduleAddPublisher: PassthroughSubject<Void, Never> { get }
}

protocol ListViewModelInterface {
    var input: ListViewModelInputInterface { get }
    var output: ListViewModelOutputInterface { get }
}

final class ListViewModel: ListViewModelInterface, ListViewModelOutputInterface {
    var schedules: [ScheduleModel] = []

    var input: ListViewModelInputInterface { self }
    var output: ListViewModelOutputInterface { self }
    var scheduleAddPublisher = PassthroughSubject<Void, Never>()
}

extension ListViewModel: ListViewModelInputInterface {
    func tappedAddButton() {
        scheduleAddPublisher.send()
    }
}
