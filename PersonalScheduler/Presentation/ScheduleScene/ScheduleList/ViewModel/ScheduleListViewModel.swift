//
//  ScheduleListViewModel.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

struct ScheduleListViewModelActions {
    let showScheduleDetails: (Schedule) -> Void
    let createNewSchedule: () -> Void
}

protocol ScheduleListViewModelInput {
    func didSelectItemAt(_ indexPath: Int)
    func deleteSchedule(_ schedule: Schedule) async throws
    func createNewSchedule()
    func fetchData() async throws
}

protocol ScheduleListViewModelOutput {
    var scheduleList: Observable<[Schedule]> { get set }
}

protocol ScheduleListViewModel: ScheduleListViewModelInput, ScheduleListViewModelOutput {}

final class DefaultScheduleListViewModel: ScheduleListViewModel {
    var scheduleList = Observable<[Schedule]>([])
    private let actions: ScheduleListViewModelActions?
    private let firestoreManager: FireStoreManager
    
    init(
        fireStoreCollectionId: String,
        actions: ScheduleListViewModelActions? = nil
    ) {
        self.firestoreManager = FireStoreManager(
            fireStoreCollectionId: fireStoreCollectionId
        )
        self.actions = actions
    }
    
    func fetchData() async throws {
        let unsortedList = try await firestoreManager.read()
        
        let sortedList = unsortedList.sorted { a, b in
            let aDate = DateManager.shared.convert(text: a.startDate)
            let bDate = DateManager.shared.convert(text: b.startDate)
            return DateManager.shared.sortDescend(a: aDate, b: bDate)
        }
        
        scheduleList.value = sortedList
    }
    
    func didSelectItemAt(_ indexPath: Int) {
        let schedule = scheduleList.value[indexPath]
        actions?.showScheduleDetails(schedule)
    }
    
    func deleteSchedule(_ schedule: Schedule) async throws {
        try await firestoreManager.delete(schedule)
    }
    
    func createNewSchedule() {
        actions?.createNewSchedule()
    }
}
