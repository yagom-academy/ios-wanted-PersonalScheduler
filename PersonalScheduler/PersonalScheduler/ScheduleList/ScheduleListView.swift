//
//  ScheduleListView.swift
//  PersonalScheduler
//
//  Created by minsson on 2023/01/12.
//

import SwiftUI

struct ScheduleListView: View {
    
    @StateObject var scheduleListViewModel: ScheduleListViewModel
    @State private var shouldPresentAddingView = false
    @State private var shouldPresentEditingView = false
    @State private var selectedSchedule: Schedule = Schedule(id: "", title: "", description: "", startMoment: Date(), endMoment: Date(), status: .planned)
    
    var body: some View {
        NavigationView {
            List {
                ForEach(scheduleListViewModel.schedules) { schedule in
                    VStack {
                        Text(schedule.title)
                        Text(schedule.description)
                        Text(schedule.startMoment.toString())
                        Text(schedule.endMoment.toString())
                    }.onTapGesture {
                        selectedSchedule = schedule
                        shouldPresentEditingView.toggle()
                    }
                    .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onEnded({ value in
                            if value.translation.width < 0 {
                                scheduleListViewModel.scheduleCellSwipedToLeft(schedule: schedule)
                                scheduleListViewModel.fetchDataFromFirestore(firebaseID: scheduleListViewModel.firebaseID)
                            }
                        }))
                }
            }.sheet(isPresented: $shouldPresentEditingView) {
                ScheduleEditingView(scheduleListViewModel: scheduleListViewModel, shouldPresentEditingView: $shouldPresentEditingView, selectedSchedule: $selectedSchedule)
            }
            .navigationTitle("Schedules")
            .navigationBarItems(trailing: Button(action: {
                shouldPresentAddingView.toggle()
            }, label: {
                Image(systemName: "plus")
            }))
            .sheet(isPresented: $shouldPresentAddingView) {
                ScheduleAddingView(scheduleListViewModel: scheduleListViewModel, shouldPresentAddingView: $shouldPresentAddingView)
            }
        }
    }
}

struct ScheduleListView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleListView(scheduleListViewModel: ScheduleListViewModel(firebaseID: ""))
    }
}
