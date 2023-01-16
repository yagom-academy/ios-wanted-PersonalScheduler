//
//  ListViewModel.swift
//  PersonalScheduler
//
//  Created by unchain on 2023/01/11.
//

import Foundation
import Combine
import FirebaseAuth
import KakaoSDKUser

protocol ListViewModelInputInterface {
    func tappedAddButton()
    func onViewWillAppear()
    func deleteButtonDidTap(user: String, indexPath: IndexPath)
    func didSelectCell(indexPath: IndexPath)
    func tappedLogoutButton()
}

protocol ListViewModelOutputInterface {
    var scheduleAddPublisher: PassthroughSubject<Void, Never> { get }
    var tableViewReloadPublisher: PassthroughSubject<Void, Never> { get }
    var didSelectCellPublisher: PassthroughSubject<ScheduleModel, Never> { get }
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
    var didSelectCellPublisher = PassthroughSubject<ScheduleModel, Never>()

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

    private var readSchedule: ScheduleModel = ScheduleModel(documentId: "",
                                                            title: "",
                                                            startDate: "",
                                                            mainText: "")

    func fetchSchedule() {
        guard let UUID = UserDefaults.standard.string(forKey: "uid"), UUID.isEmpty == false else { return }
        FirebaseManager.shared.readData(user: UUID) { [weak self] schedule in
            guard let self = self else { return }
            self.allSchedules = schedule
        }
    }

    private func handleKakaoLogout() {
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            } else {
                do {
                    try Auth.auth().signOut()
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension ListViewModel: ListViewModelInputInterface {
    func didSelectCell(indexPath: IndexPath) {
        FirebaseManager.shared.readDocument(user: UserDefaults.standard.string(forKey: "uid") ?? "", document: allSchedules[indexPath.row].documentId ?? "") { data in
            self.readSchedule = data
        }
        didSelectCellPublisher.send(readSchedule)
    }

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

    func tappedLogoutButton() {
        handleKakaoLogout()
    }
}
