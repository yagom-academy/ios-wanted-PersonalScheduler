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
    func onViewWillAppear()
    func deleteButtonDidTap(user: String, indexPath: IndexPath)
}

protocol ListViewModelOutputInterface {
    var scheduleAddPublisher: PassthroughSubject<Void, Never> { get }
    var tableViewReloadPublisher: PassthroughSubject<Void, Never> { get }
}

protocol ListViewModelInterface {
    var input: ListViewModelInputInterface { get }
    var output: ListViewModelOutputInterface { get }
}

final class ListViewModel: ListViewModelInterface, ListViewModelOutputInterface {
    var input: ListViewModelInputInterface { self }
    var output: ListViewModelOutputInterface { self }
    var scheduleAddPublisher = PassthroughSubject<Void, Never>()
    var tableViewReloadPublisher = PassthroughSubject<Void, Never>()

    private var allSchedules = [ScheduleModel]() {
        didSet {
            DispatchQueue.main.async {
                self.schedules = self.allSchedules
            }
        }
    }

    var schedules = [ScheduleModel]() {
        didSet {
            DispatchQueue.main.async {
                self.tableViewReloadPublisher.send()
            }
        }
    }

    func fetchSchedule() {
        FirebaseManager.shared.readData(user: "user") { [weak self] schedule in
            guard let self = self else { return }
            self.allSchedules = schedule
        }
    }
}

extension ListViewModel: ListViewModelInputInterface {
    func deleteButtonDidTap(user: String, indexPath: IndexPath) {
        FirebaseManager.shared.deleteData(user: user, indexPath: indexPath, cellData: allSchedules)
        fetchSchedule()
    }

    func onViewWillAppear() {
        fetchSchedule()
    }

    func tappedAddButton() {
        scheduleAddPublisher.send()
    }
}
