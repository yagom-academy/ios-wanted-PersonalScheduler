//
//  ScheduleListViewModel.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import Foundation
import Combine

protocol ScheduleListViewModelInput {
    
    func viewDidLoad()
    func viewWillAppear()
    func delete(schedule: Schedule)
    func selectedDate(_ date: Date)
    
}

protocol ScheduleListViewModelOutput {
    
    var schedules: AnyPublisher<[Schedule], Never> { get }
    var errorMessage: AnyPublisher<String?, Never> { get }
    var isLoading: AnyPublisher<Bool, Never> { get }
    var currentSelectedDate: Date { get }
    
}

protocol ScheduleListViewModel {
    
    var input: ScheduleListViewModelInput { get }
    var output: ScheduleListViewModelOutput { get }
    
    var cancellables: Set<AnyCancellable> { get }
    
}

final class DefaultScheduleListViewModel: ScheduleListViewModel {
    
    private(set) var cancellables: Set<AnyCancellable> = .init()
    private let userRepository: UserRepository
    private let scheduleRepository: ScheduleRepository
    
    private var _schedules = CurrentValueSubject<[Schedule], Never>([])
    private var _errorMessage = CurrentValueSubject<String?, Never>(nil)
    private var _isLoading = CurrentValueSubject<Bool, Never>(true)
    private var _currentSelectedDate = CurrentValueSubject<Date, Never>(Date())
    
    private var _currentSchedules = [Schedule]() {
        didSet {
            _schedules.send(_currentSchedules.sorted { $0.startDate < $1.startDate })
        }
    }
    init(
        userRepository: UserRepository = DefaultUserRepository(),
        scheduleRepository: ScheduleRepository = DefaultScheduleRepository()
    ) {
        self.userRepository = userRepository
        self.scheduleRepository = scheduleRepository
    }
    
}

extension DefaultScheduleListViewModel: ScheduleListViewModelInput {
    
    var input: ScheduleListViewModelInput { self }

    func viewDidLoad() {
        scheduleRepository.read()
            .sink(receiveCompletion: { [weak self] complection in
                if case let .failure(error) = complection {
                    debugPrint(error)
                    self?._errorMessage.send("데이터를 불러오는 도중에 알 수 없는 에러가 발생했습니다.")
                }
                self?._isLoading.send(false)
            }, receiveValue: { [weak self] schedules in
                self?._currentSchedules = schedules
            }).store(in: &cancellables)
    }
    
    func viewWillAppear() {
        guard let schedules = userRepository.getLocalUserInfo()?.schedules else {
            return
        }
        _currentSchedules = schedules
    }
    
    func delete(schedule: Schedule) {
        let schedules = _schedules.value.filter { $0 != schedule }
        scheduleRepository.delete(schedule: schedule)
            .sink(receiveCompletion: { [weak self] complection in
                if case let .failure(error) = complection {
                    debugPrint(error)
                    self?._errorMessage.send("변경사항을 서버에 반영하는 도중에 알 수 없는 에러가 발생했습니다.")
                }
            }, receiveValue: { [weak self] isSuccess in
                if isSuccess {
                    self?._currentSchedules = schedules
                }
            }).store(in: &cancellables)
        
    }
    
    func selectedDate(_ date: Date) {
        _currentSelectedDate.send(date)
    }
}

extension DefaultScheduleListViewModel: ScheduleListViewModelOutput {
    
    var output: ScheduleListViewModelOutput { self }
    
    var schedules: AnyPublisher<[Schedule], Never> { _schedules.eraseToAnyPublisher() }
    var errorMessage: AnyPublisher<String?, Never> { _errorMessage.eraseToAnyPublisher() }
    var isLoading: AnyPublisher<Bool, Never> { _isLoading.eraseToAnyPublisher() }
    var currentSelectedDate: Date { _currentSelectedDate.value }

}
