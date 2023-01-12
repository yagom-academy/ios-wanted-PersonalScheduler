//
//  ScheduleListViewModel.swift
//  PersonalScheduler
//
//  Created by 천수현 on 2023/01/11.
//

import UIKit

final class ScheduleListViewModel {
    private var schedules = [Schedule]()
    private let calendar = Calendar.current
    private(set) var currentDate = Date() {
        didSet {
            applyCalendarDataSource?()
        }
    }

    // MARK: - Outputs
    var days: [Date] {
        guard let interval = calendar.dateInterval(of: .month, for: currentDate),
              let dayCount = calendar.dateComponents([.day], from: interval.start, to: interval.end).day else { return [] }

        let currentComponent = calendar.dateComponents([.year, .month], from: currentDate)
        guard let year = currentComponent.year,
              let month = currentComponent.month else { return [] }
        return (1...dayCount).compactMap {
            return DateComponents(calendar: calendar, year: year, month: month, day: $0).date
        }
    }

    func schedules(section: ScheduleListViewController.ScheduleSection) -> [Schedule] {
        let now = Date()
        switch section {
        case .current:
            return schedules.filter { $0.startDate < now && now < $0.endDate } // TODO: Need to make filter logic
        case .upcoming:
            return schedules.filter { now < $0.startDate }
        case .done:
            return schedules.filter { $0.endDate < now }
        }
    }

    var applyCalendarDataSource: (() -> Void)?
    var applyScheduleDataSource: (() -> Void)?
    var showAlert: ((UIAlertController) -> Void)?
    var setCurrentMonthLabel: ((String) -> Void)?
    var selectItemAt: ((IndexPath) -> Void)?

    // MARK: - UseCases
    private let fetchScheduleUseCase: FetchScheduleUseCase

    init(fetchScheduleUseCase: FetchScheduleUseCase) {
        self.fetchScheduleUseCase = fetchScheduleUseCase
    }
}

// MARK: - Inputs
extension ScheduleListViewModel {
    func viewDidLoad() {
        fetchSchedules(date: Date())
    }

    func viewWillAppear() {
        self.applyCalendarDataSource?()
        selectCurrentDate()
    }

    func dateCellSelected(indexPath: IndexPath) {

    }

    func deleteActionDone(indexPath: IndexPath) {

    }

    func todayButtonTapped() {
        currentDate = Date()
        selectCurrentDate()
    }

    func previousMonthButtonTapped() {
        guard let nextMonthDate = calendar.date(byAdding: .month, value: -1, to: currentDate) else { return }
        currentDate = nextMonthDate
        setCurrentMonthLabel?(nextMonthDate.toCurrentMonthText())
    }

    func nextMonthButtonTapped() {
        guard let nextMonthDate = calendar.date(byAdding: .month, value: 1, to: currentDate) else { return }
        currentDate = nextMonthDate
        setCurrentMonthLabel?(nextMonthDate.toCurrentMonthText())
    }
}

// MARK: - Private Methods

extension ScheduleListViewModel {
    private func fetchSchedules(date: Date) {
        fetchScheduleUseCase.execute(for: date) { result in
            switch result {
            case .success(let schedules):
                self.schedules = schedules
                self.applyScheduleDataSource?()
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription,
                                              preferredStyle: .alert)
                self.showAlert?(alert)
            }
        }
    }

    private func selectCurrentDate() {
        if let day = calendar.dateComponents([.year, .month, .day], from: currentDate).day {
            selectItemAt?(IndexPath(row: day - 1, section: 0))
        }
    }
}

// MARK: - Date Extension

fileprivate extension Date {
    func toCurrentMonthText() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월"
        return dateFormatter.string(from: self)
    }
}
