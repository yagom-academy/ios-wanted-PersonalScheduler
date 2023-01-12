//
//  ScheduleAddingView.swift
//  PersonalScheduler
//
//  Created by minsson on 2023/01/12.
//

import SwiftUI

struct ScheduleAddingView: View {
    
    @Binding var shouldPresentAddingView: Bool
    @State private var newSchedule: Schedule = Schedule(
        id: UUID().uuidString,
        title: "",
        description: "",
        startTime: Date(),
        endTime: Date(),
        status: .planned
    )
    
    var body: some View {
        NavigationView {
            Text("")
            .navigationTitle("새로운 일정")
            .navigationBarItems(trailing: Button(action: {
                shouldPresentAddingView.toggle()
            }, label: {
                Image(systemName: "저장")
            }))
        }
    }
}

struct ScheduleAddingView_Previews: PreviewProvider {
    
    @State static var shouldPresentSheet = false
    
    static var previews: some View {
        ScheduleAddingView(shouldPresentAddingView: $shouldPresentSheet)
    }
    
}
    }
}
