//
//  ScheduleViewModel.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import Foundation
import Combine

protocol ScheduleViewModelInput {
    
    func viewDidLoad()
    func didTapSaveButton(title: String, description: String)
    func didChangeStartDate(_ date: Date)
    func didChangeEndDate(_ date: Date)
    
}

protocol ScheduleViewModelOutput {
    
    var title: AnyPublisher<String?, Never> { get }
    var startDate: AnyPublisher<Date, Never> { get }
    var endDate: AnyPublisher<Date, Never> { get }
    var description: AnyPublisher<String?, Never> { get }
    var isValidDate: AnyPublisher<Bool, Never> { get }
    var isLoading: AnyPublisher<Bool, Never> { get }
    var errorMessage: AnyPublisher<String?, Never> { get }
    var isCompleted: AnyPublisher<Bool, Never> { get }
    var currentStartData: Date { get }
    var currentEndData: Date { get }

}

protocol ScheduleViewModel {
    
    var input: ScheduleViewModelInput { get }
    var output: ScheduleViewModelOutput { get }
    
    var cancellables: Set<AnyCancellable> { get }
    
}

final class DefaultScheduleViewModel: ScheduleViewModel {
    
    private(set) var cancellables: Set<AnyCancellable> = .init()
    private let type: ScheduleViewController.ViewType
    private var _schedule: Schedule
    
    private let scheduleRepository: ScheduleRepository

    private var _title = CurrentValueSubject<String?, Never>(nil)
    private var _startDate = CurrentValueSubject<Date, Never>(Date().nearestHour())
    private var _endDate = CurrentValueSubject<Date, Never>(Date().nearestHour().plusHour(1))
    private var _description = CurrentValueSubject<String?, Never>(nil)
    private var _isValidDate =  CurrentValueSubject<Bool, Never>(true)
    private var _isLoading =  CurrentValueSubject<Bool, Never>(true)
    private var _errorMessage =  CurrentValueSubject<String?, Never>(nil)
    private var _isCompleted = CurrentValueSubject<Bool, Never>(false)
    
    init(
        schedule: Schedule,
        type: ScheduleViewController.ViewType,
        scheduleRepository: ScheduleRepository = DefaultScheduleRepository()
    ) {
        self._schedule = schedule
        self.type = type
        self.scheduleRepository = scheduleRepository
    }
}

private extension DefaultScheduleViewModel {
    
    func errorhandling(_ error: Error, message: String) {
        debugPrint(error)
        _errorMessage.send(message)
    }
    
}

extension DefaultScheduleViewModel: ScheduleViewModelInput {
    
    var input: ScheduleViewModelInput { self }

    func viewDidLoad() {
        switch type {
        case .edit:
            _title.send(_schedule.title)
            _startDate.send(_schedule.startDate)
            _endDate.send(_schedule.endDate)
            _description.send(_schedule.description)
        default: break
        }
        _isLoading.send(false)
    }
    
    func didTapSaveButton(title: String, description: String) {
        guard title.count >= 1 else {
            _errorMessage.send("일정 제목 입력은 필수입니다.")
            return
        }
        _isLoading.send(true)
        let newSchedule = Schedule(
            id: type == .create ? UUID().uuidString : _schedule.id,
            title: title,
            startDate: _startDate.value,
            endDate: _endDate.value,
            description: description
        )
        switch type {
        case .edit:
            scheduleRepository.update(schedule: newSchedule)
                .sink(receiveCompletion: { [weak self] complection in
                    if case let .failure(error) = complection {
                        self?.errorhandling(error, message: "일정을 저장하는 도중에 알 수 없는 에러가 발생했습니다.")
                    }
                    self?._isLoading.send(false)
                }, receiveValue: { [weak self] isSuccess in
                    self?._isCompleted.send(isSuccess)
                }).store(in: &cancellables)
        case .create:
            scheduleRepository.write(schedule: newSchedule)
                .sink(receiveCompletion: { [weak self] complection in
                    if case let .failure(error) = complection {
                        self?.errorhandling(error, message: "새 일정을 등록하는 도중에 알 수 없는 에러가 발생했습니다.")
                    }
                self?._isLoading.send(false)
                }, receiveValue: { [weak self] isSuccess in
                    self?._isCompleted.send(isSuccess)
                }).store(in: &cancellables)
        }
    }
    
    func didChangeStartDate(_ date: Date) {
        _startDate.send(date)
        if _endDate.value.isFuture(from: date) {
            _isValidDate.send(false)
        } else {
            _isValidDate.send(true)
        }
    }
    
    func didChangeEndDate(_ date: Date) {
        _endDate.send(date)
        if date.isFuture(from: _startDate.value) {
            _isValidDate.send(false)
        } else {
            _isValidDate.send(true)
        }
    }
}

extension DefaultScheduleViewModel: ScheduleViewModelOutput {
    
    var output: ScheduleViewModelOutput { self }
    
    var title: AnyPublisher<String?, Never> { _title.eraseToAnyPublisher() }
    var startDate: AnyPublisher<Date, Never> { _startDate.eraseToAnyPublisher() }
    var endDate: AnyPublisher<Date, Never> { _endDate.eraseToAnyPublisher() }
    var description: AnyPublisher<String?, Never> { _description.eraseToAnyPublisher() }
    var isValidDate: AnyPublisher<Bool, Never> { _isValidDate.eraseToAnyPublisher() }
    var isLoading: AnyPublisher<Bool, Never> { _isLoading.eraseToAnyPublisher() }
    var errorMessage: AnyPublisher<String?, Never> { _errorMessage.eraseToAnyPublisher() }
    var isCompleted: AnyPublisher<Bool, Never> { _isCompleted.eraseToAnyPublisher() }
    var currentStartData: Date { _startDate.value }
    var currentEndData: Date { _endDate.value }

}
