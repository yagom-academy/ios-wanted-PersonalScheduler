//
//  ListViewModel.swift
//  PersonalScheduler
//
//  Created by unchain on 2023/01/11.
//

import Foundation
import Combine

protocol ListViewModelInputInterface {
}

protocol ListViewModelOutputInterface {
    var kakaoLoginPublisher: PassthroughSubject<Void, Never> { get }
}

protocol ListViewModelInterface {
    var input: ListViewModelInputInterface { get }
    var output: ListViewModelOutputInterface { get }
}

final class ListViewModel: ListViewModelInterface, ListViewModelOutputInterface {
    var schedules: [ScheduleModel] = []

    var input: ListViewModelInputInterface { self }
    var output: ListViewModelOutputInterface { self }

    var kakaoLoginPublisher = PassthroughSubject<Void, Never>()
}

extension ListViewModel: ListViewModelInputInterface {

}
