//
//  ScheduleListView.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/09.
//

import SwiftUI

struct ScheduleListView: View {
    
    @StateObject var scheduleListViewModel = ScheduleListViewModel()

    var body: some View {
                
        VStack {
            List {
                ForEach(scheduleListViewModel.lists, id: \.id) { data in
                    Text("\(data.title)")
                }
            }
        }
        .navigationBarTitle("ScheduleList")
    }
}

struct ScheduleListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScheduleListView()
        }
    }
}
