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
    func visibleTopSchedule(_ schedule: Schedule)
    func didTapLogout()
    
}

protocol ScheduleListViewModelOutput {
    
    var schedules: AnyPublisher<[Schedule], Never> { get }
    var currentSchedules: [Schedule] { get }
    var errorMessage: AnyPublisher<String?, Never> { get }
    var isLoading: AnyPublisher<Bool, Never> { get }
    var currentSelectedDate: Date { get }
    var showSelectedDate: AnyPublisher<Int?, Never> { get }
    var visibleTopSchedule: AnyPublisher<Schedule?, Never> { get }
    var currentSchedule: Schedule? { get }
    var logout: AnyPublisher<Bool?, Never> { get }
    
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
    private var _showSelectedDate = CurrentValueSubject<Int?, Never>(nil)
    private var _visibleTopSchedule = CurrentValueSubject<Schedule?, Never>(nil)
    private var _logout = CurrentValueSubject<Bool?, Never>(nil)
    
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
                    Logger.debug(error: error, message: "Remote에서 스케줄 목록 불러오기 실패")
                    self?._errorMessage.send("데이터를 불러오는 도중에 알 수 없는 에러가 발생했습니다.")
                }
                self?._isLoading.send(false)
            }, receiveValue: { [weak self] schedules in
                self?._currentSchedules = schedules
                if let index = schedules.firstIndex(where: { $0.isProgressing }) {
                    self?._showSelectedDate.send(index)
                }
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
        _currentSchedules = schedules
        scheduleRepository.delete(schedule: schedule)
            .sink(receiveCompletion: { [weak self] complection in
                if case let .failure(error) = complection {
                    Logger.debug(error: error, message: "스케줄 삭제 실패")
                    self?._errorMessage.send("변경사항을 서버에 반영하는 도중에 알 수 없는 에러가 발생했습니다.")
                }
            }, receiveValue: { _ in }).store(in: &cancellables)
        
    }
    
    func selectedDate(_ date: Date) {
        guard date != _visibleTopSchedule.value?.startDate else {
            return
        }
        _currentSelectedDate.send(date)
        if let index = _currentSchedules.firstIndex(where: { $0.startDate.toString(.yyyyMMddEEEE) == date.toString(.yyyyMMddEEEE)  }) {
            _showSelectedDate.send(index)
        } else if let index = _currentSchedules.firstIndex(where: { $0.startDate.isEqualMonth(from: date) }) {
            _showSelectedDate.send(index)
            _errorMessage.send("선택한 날짜에 일정이 존재하지 않습니다.")
            _visibleTopSchedule.send(_currentSchedules[index])
        } else {
            _errorMessage.send("선택한 날짜에 일정이 존재하지 않습니다.")
        }
    }
    
    func visibleTopSchedule(_ schedule: Schedule) {
        _visibleTopSchedule.send(schedule)
    }
    
    func didTapLogout() {
        userRepository.logout()
        _logout.send(true)
    }
}

extension DefaultScheduleListViewModel: ScheduleListViewModelOutput {
    
    var output: ScheduleListViewModelOutput { self }
    
    var schedules: AnyPublisher<[Schedule], Never> { _schedules.eraseToAnyPublisher() }
    var currentSchedules: [Schedule] { _schedules.value }
    var errorMessage: AnyPublisher<String?, Never> { _errorMessage.eraseToAnyPublisher() }
    var isLoading: AnyPublisher<Bool, Never> { _isLoading.eraseToAnyPublisher() }
    var currentSelectedDate: Date { _currentSelectedDate.value }
    var showSelectedDate: AnyPublisher<Int?, Never> { _showSelectedDate.eraseToAnyPublisher() }
    var visibleTopSchedule: AnyPublisher<Schedule?, Never> { _visibleTopSchedule.eraseToAnyPublisher() }
    var currentSchedule: Schedule? { _visibleTopSchedule.value }
    var logout: AnyPublisher<Bool?, Never> { _logout.eraseToAnyPublisher() }

}
