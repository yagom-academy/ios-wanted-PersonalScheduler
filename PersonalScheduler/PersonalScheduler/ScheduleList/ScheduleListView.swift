//
//  ScheduleListView.swift
//  PersonalScheduler
//
//  Created by minsson on 2023/01/12.
//

import SwiftUI

struct ScheduleListView: View {
    
    @StateObject var scheduleListViewModel: ScheduleListViewModel
    @State var shouldPresentAddingView = false
    
    var body: some View {
        NavigationView {
            List(scheduleListViewModel.schedules, id: \.id) { schedule in
                Text(schedule.title)
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
